import importlib
import inspect
import threading
from functools import partial
from distutils.version import LooseVersion

from apscheduler.schedulers.background import BackgroundScheduler
from interruptingcow import timeout
from pytz import utc

from const import DEFAULT_COMMAND_TIMEOUT
from exceptions import WorkerTimeoutError
from workers_queue import _WORKERS_QUEUE
import logger

from pip import __version__ as pip_version

if LooseVersion(pip_version) >= LooseVersion("10"):
    if LooseVersion(pip_version) >= LooseVersion("19.3.1"):
        from pip._internal.main import main as pip_main
    else:
        from pip._internal import main as pip_main
else:
    from pip import main as pip_main

import json
from config import settings

from mqtt import MqttMessage
import yaml
import os
import sys


_LOGGER = logger.get(__name__)

class WorkersManager:
    topic_prefix="maintenance"
    
    def format_topic(self, topic_args):
        return "/".join([self.topic_prefix, topic_args])

    class Command:
        def __init__(self, callback, timeout, args=(), options=dict()):
            self._callback = callback
            self._timeout = timeout
            self._args = args
            self._options = options
            self._source = "{}.{}".format(
                callback.__self__.__class__.__name__
                if hasattr(callback, "__self__")
                else callback.__module__,
                callback.__name__,
            )

        def execute(self):
            messages = []

            try:
                with timeout(
                        self._timeout,
                        exception=WorkerTimeoutError(
                            "Execution of command {} timed out after {} seconds".format(
                                self._source, self._timeout
                            )
                        ),
                ):
                    if inspect.isgeneratorfunction(self._callback):
                        for message in self._callback(*self._args):
                            messages += message
                    else:
                        messages = self._callback(*self._args)
            except WorkerTimeoutError as e:
                if messages:
                    logger.log_exception(
                        _LOGGER, "%s, sending only partial update", e, suppress=True
                    )
                else:
                    raise e

            _LOGGER.debug("Execution result of command %s: %s", self._source, messages)
            return messages

    def __init__(self, config):
        self._mqtt_callbacks = []
        self._config_commands = []
        self._update_commands = []
        self._scheduler = BackgroundScheduler(timezone=utc)
        self._daemons = []
        self._config = config
        self._command_timeout = config.get("command_timeout", DEFAULT_COMMAND_TIMEOUT)

    def register_workers(self, global_topic_prefix,mqtt):
        for (worker_name, worker_config) in self._config["workers"].items():
            module_obj = importlib.import_module("workers.%s" % worker_name)
            klass = getattr(module_obj, "%sWorker" % worker_name.title())

            if module_obj.REQUIREMENTS is not None:
                self._pip_install_helper(module_obj.REQUIREMENTS)

            command_timeout = worker_config.get(
                "command_timeout", self._command_timeout
            )
            worker_obj = klass(
                command_timeout, global_topic_prefix, **worker_config["args"]
            )
            
            if hasattr(worker_obj, "status_update"):
                _LOGGER.debug(
                    "Added %s worker with %d seconds interval and a %d seconds timeout",
                    repr(worker_obj),
                    worker_config["update_interval"],
                    worker_obj.command_timeout,
                )
                command = self.Command(
                    worker_obj.status_update, worker_obj.command_timeout, []
                )
                self._update_commands.append(command)

                if "update_interval" in worker_config:
                    job_id = "{}_interval_job".format(worker_name)
                    self._scheduler.add_job(
                        partial(self._queue_command, command),
                        "interval",
                        seconds=worker_config["update_interval"],
                        id=job_id,
                    )
                    self._mqtt_callbacks.append(
                        (
                            worker_obj.format_topic("update_interval"),
                            partial(self._update_interval_wrapper, command, job_id),
                        )
                    )
                
            elif hasattr(worker_obj, "run"):
                _LOGGER.debug("Registered %s as daemon", repr(worker_obj))
                self._daemons.append(worker_obj)
            else:
                raise "%s cannot be initialized, it has to define run or status_update method" % worker_name

            if "topic_subscription" in worker_config:
                self._mqtt_callbacks.append(
                    (
                        worker_config["topic_subscription"],
                        self._on_command_wrapper,
                    )
                )

        if "topic_subscription" in self._config:
            for (callback_name, options) in self._config["topic_subscription"].items():
                self._mqtt_callbacks.append(
                    (
                        options["topic"],
                        lambda client, _, c: self._queue_if_matching_payload(
                            self.Command(
                                getattr(self, callback_name), self._command_timeout
                            ),
                            c.payload,
                            options["payload"],
                        ),
                    )
                )
        if "config_topic" in self._config:   
            self._mqtt_callbacks.append(
                (
                self.topic_prefix,
                partial(self._command_maintenance_handler,mqtt),
                )
            )

    def send_configfile(self, mqtt):
        messages = []
        if "config_topic" in self._config: 
            _LOGGER.info("Sending config file...")
            
            messages.append(
                MqttMessage(
                    topic=self.format_topic("CONFIG_FILE"),
                    payload= json.dumps(settings),
                    )
                )
            mqtt.publish(messages)

    def start(self, mqtt):
        self.send_configfile(mqtt)
        mqtt.callbacks_subscription(self._mqtt_callbacks)

        self._scheduler.start()
        for daemon in self._daemons:
            threading.Thread(target=daemon.run, args=[mqtt], daemon=True).start()

    def _queue_if_matching_payload(self, command, payload, expected_payload):
        if payload.decode("utf-8") == expected_payload:
            self._queue_command(command)

    def update_all(self):
        _LOGGER.debug("Updating all workers")
        for command in self._update_commands:
            self._queue_command(command)

    @staticmethod
    def _queue_command(command):
        _WORKERS_QUEUE.put(command)

    @staticmethod
    def _pip_install_helper(package_names):
        for package in package_names:
            pip_main(["install", "-q", package])
        logger.reset()

    def _update_interval_wrapper(self, command, job_id, client, userdata, c):
        _LOGGER.info("Recieved updated interval for %s with: %s", c.topic, c.payload)
        try:
            new_interval = int(c.payload)
            self._scheduler.remove_job(job_id)
            self._scheduler.add_job(
                partial(self._queue_command, command),
                "interval",
                seconds=new_interval,
                id=job_id,
            )
        except ValueError:
            logger.log_exception(
                _LOGGER, "Ignoring invalid new interval: %s", c.payload
            )

    def _on_command_wrapper(self,client, userdata, c):
        _LOGGER.debug("Received command on %s: %s", c.topic, c.payload)

        global_topic_prefix = userdata["global_topic_prefix"]
        topic = (
            c.topic[len(global_topic_prefix + "/"):]
            if global_topic_prefix is not None
            else c.topic
        )
        self._queue_command(
            self.Command(
                worker_obj.on_command, worker_obj.command_timeout, [topic, c.payload]
            )
        )

    def writeintofile(self,settings,mqtt):
        with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), "config.yaml"), "w") as yamlfile:
                data = yaml.dump(settings, yamlfile, sort_keys=False)
                yamlfile.close()
        #update config file mqtt
        self.send_configfile(mqtt)
 
    def restart_program(self):
        python = sys.executable
        #os.execl(python, python, * sys.argv)
        os.execv(__file__, sys.argv)

    def _command_maintenance_handler(self,mqtt, client, userdata, c):
        payload=json.loads(c.payload)
        
        try:
            _LOGGER.debug("Received maintenance command on %s: %s", c.topic, payload)
            if payload["command"] == "add":
                _LOGGER.info("Adding: %s - %s", payload["name"] , payload["mac"])

                settings['manager']['workers']['blescanmulti']['args']['devices'] [str(payload['name'])]= str(payload['mac'])            
                self.writeintofile(settings,mqtt)
            
            elif payload["command"] == 'remove':
                _LOGGER.info("Removing: %s device", payload["name"])

                del settings['manager']['workers']['blescanmulti']['args']['devices'] [payload['name']]
                self.writeintofile(settings,mqtt)

            elif payload["command"] == 'set_gateway':
                _LOGGER.info("Setting gateway topic prefix: %s", payload["name"])  
                
                settings['mqtt']['global_topic_prefix']=str(payload['name'])
                self.writeintofile(settings,mqtt)

            elif payload["command"] == 'scan':
                _LOGGER.info("Scanning...")

                self.update_all()

            elif payload["command"] == 'restart':
                #update device number after config_file modification
                _LOGGER.info("Restarting...")
                self.restart_program()
            else:
                _LOGGER.info("Received unknown maintenance command: %s.. }", payload)

        except KeyError:
            logger.log_exception(
                _LOGGER,
                "Wrong command Payload (%s)",
                repr(self),
            )
