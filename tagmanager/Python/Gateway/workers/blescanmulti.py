import time

from mqtt import MqttMessage

from workers.base import BaseWorker
from utils import booleanize
import logger

from datetime import datetime

REQUIREMENTS = ["bluepy"]
_LOGGER = logger.get(__name__)


class BleDeviceStatus:
    def __init__(
        self,
        worker,
        mac: str,
        name: str,
        available: bool = False,
        last_status_time: float = None,
        message_sent: bool = False,
    ):
        if last_status_time is None:
            last_status_time = time.time()
        if name is None:
            name = "Unregistred"
            message_available = True

        self.worker = worker  # type: BlescanmultiWorker
        self.mac = mac.lower()
        self.name = name
        self.available = available
        self.last_status_time = last_status_time
        self.message_sent = False
    
    def get_mac(self):
        return self.mac

    def set_status(self, available):
        if available != self.available:
            self.available = available
            self.last_status_time = time.time()
            self.message_sent = False
    
    def _timeout(self):
        if self.available:
            return self.worker.available_timeout
        else:
            return self.worker.unavailable_timeout

    def has_time_elapsed(self):
        elapsed = time.time() - self.last_status_time
        return elapsed > self._timeout()

    def payload(self):
        if self.available:
            return self.worker.available_payload
        else:
            return self.worker.unavailable_payload

    def generate_messages(self, device):
        dateTimeObj = datetime.now()
        messages = []
        if  self.has_time_elapsed():
            #not self.message_sent notify only when the state change 
            self.message_sent = True
            messages.append(
                MqttMessage(
                    topic=self.worker.format_topic("{}".format(self.name)),
                    payload={"mac": self.mac ,"status":self.payload(),"date":dateTimeObj.strftime('%Y-%m-%dT%H:%M:%SZ')},
                 )
            )
            #rssi
            if self.available:
                messages.append(
                    MqttMessage(
                        topic=self.worker.format_topic(
                            "{}/rssi".format(self.name)
                        ),
                        payload=device.rssi,
                    )
                )
            else:
                messages.append(
                    MqttMessage(
                        topic=self.worker.format_topic(
                            "{}/rssi".format(self.name)
                        ),
                        payload="null",
                    )
                )
        return messages

    def unregistred_generate_messages(self, pos):
        dateTimeObj = datetime.now()
        messages = []
        self.message_sent=True
        messages.append(
            MqttMessage(
                topic=self.worker.format_topic(str(pos)),
                payload={"mac": self.mac,"date":dateTimeObj.strftime('%Y-%m-%dT%H:%M:%SZ')},
            )
        )
        return messages
        
class BlescanmultiWorker(BaseWorker):
    # Default values
    devices = {}
    # Payload that should be send when device is available
    available_payload = "in"  # type: str
    # Payload that should be send when device is unavailable
    unavailable_payload = "out"  # type: str
    # After what time (in seconds) we should inform that device is available (default: 0 seconds)
    available_timeout = 0  # type: float
    # After what time (in seconds) we should inform that device is unavailable (default: 60 seconds)
    unavailable_timeout = 0  # type: float
    scan_timeout = 10.0  # type: float
    scan_passive = True  # type: str or bool


    last_status=[]
    unregistred_status = []

    def __init__(self, command_timeout, global_topic_prefix, **kwargs):
        from bluepy.btle import Scanner, DefaultDelegate

        class ScanDelegate(DefaultDelegate):
            
            topic_prefix="maintenance/unregistred"
            def format_topic(self, topic_args):
                return "/".join([self.topic_prefix, topic_args])

            def __init__(self):
                DefaultDelegate.__init__(self)
          
            def get_unregistred (self,mac):
                for unregistred in BlescanmultiWorker.unregistred_status:
                    if unregistred.mac == mac:
                        return unregistred

            def check_isNew(self, mac):
                ret=True
                for device in BlescanmultiWorker.devices:
                    if device.mac == mac:
                        BlescanmultiWorker.unregistred_status.remove(self.get_unregistred(mac))
                        ret= False
                for udevice in BlescanmultiWorker.unregistred_status:
                    if udevice.mac == mac:
                        #BlescanmultiWorker.unregistred_status.remove(self.get_unregistred(mac))
                        ret= False
                for udevice in BlescanmultiWorker.last_status:
                    if udevice.mac == mac:
                        BlescanmultiWorker.unregistred_status.remove(self.get_unregistred(mac))
                        ret= False
                return ret

            def handleDiscovery(self, dev, isNewDev, isNewData):
                if isNewDev and self.check_isNew(dev.addr):
                    _LOGGER.debug("Discover new device: %s", dev.addr)
                    #if not self.check_unregistred(dev.addr,BlescanmultiWorker.devices):
                    BlescanmultiWorker.unregistred_status.append(BleDeviceStatus(self, dev.addr, None))
               
        super(BlescanmultiWorker, self).__init__(
            command_timeout, global_topic_prefix, **kwargs
        )
        self.scanner = Scanner().withDelegate(ScanDelegate())
        self.last_status = [
            BleDeviceStatus(self, mac, name) for name, mac in self.devices.items()
        ]
        _LOGGER.info("Adding %d %s devices", len(self.devices), repr(self))

    def status_update(self):
        from bluepy import btle

        _LOGGER.info("Updating %d %s devices", len(self.devices), repr(self))

        ret = []

        if len(self.devices)!=len(self.last_status):
            self.last_status = [
            BleDeviceStatus(self, mac, name) for name, mac in self.devices.items()
            ]

        try:
            devices = self.scanner.scan(
                float(self.scan_timeout), passive=booleanize(self.scan_passive)
            )

            mac_addresses = {device.addr: device for device in devices}

            for status in self.last_status:
                for unregistred in self.unregistred_status:
                    if status.mac == unregistred.mac:
                        #print("device %s", status.mac)
                        self.unregistred_status.remove(unregistred)
                device = mac_addresses.get(status.mac, None)
                status.set_status(device is not None)
                ret += status.generate_messages(device)

            for ustatus in self.unregistred_status:
                if not ustatus.message_sent:
                    uposition=self.unregistred_status.index(ustatus)
                    ret += ustatus.unregistred_generate_messages(uposition+1)

        except btle.BTLEException as e:
            logger.log_exception(
                _LOGGER,
                "Error during update (%s)",
                repr(self),
                type(e).__name__,
                suppress=True,
            )

        return ret