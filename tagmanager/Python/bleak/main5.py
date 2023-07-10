import asyncio
from bleak import BleakScanner


class RFIDBatteryReader:
    def __init__(self, tag_mac_address, battery_service_uuid, battery_characteristic_uuid):
        self.tag_mac_address = tag_mac_address
        self.battery_service_uuid = battery_service_uuid
        self.battery_characteristic_uuid = battery_characteristic_uuid
        self.scanner = BleakScanner()

    async def read_battery_level(self):
        await self.scanner.start()
        device = await self.scanner.find_device_by_address(self.tag_mac_address)
        if device is None:
            print("Tag not found.")
            return

        await device.connect()

        battery_service = await device.get_service(self.battery_service_uuid)
        battery_characteristic = await battery_service.get_characteristic(self.battery_characteristic_uuid)

        battery_level_bytes = await battery_characteristic.read_value()
        battery_level = int.from_bytes(battery_level_bytes, byteorder='little')

        print(f"Battery level: {battery_level}%")

        await device.disconnect()

    def start_reading(self):
        loop = asyncio.get_event_loop()
        loop.run_until_complete(self.read_battery_level())
