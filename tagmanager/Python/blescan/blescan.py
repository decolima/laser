import argparse
import asyncio
from bleak import BleakScanner
from scandevicemanager import ScanDeviceManager

class ScanDevices:
    def run(self):
        parser = argparse.ArgumentParser()
        parser.add_argument(
            "--macos-use-bdaddr",
            action="store_false",
            help="when true use Bluetooth address instead of UUID on macOS",
        )
        args = parser.parse_args()

        asyncio.run(self.scan(args))

    async def scan(self, args: argparse.Namespace):
        print("scanning for 5 seconds, please wait...")
        mac_list = []

        devices = await BleakScanner.discover(
            return_adv=True, cb=dict(use_bdaddr=args.macos_use_bdaddr)
        )

        for d, a in devices.values():
            mac_list.append(d)
            #print()
            #print(d)
            #print("-" * len(str(d)))
            #print(a)

        ScanDeviceManager.save_scan_devices(mac_list)

if __name__ == "__main__":
    minha_classe = ScanDevices()
    minha_classe.run()
