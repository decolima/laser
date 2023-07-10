from main5 import RFIDBatteryReader


tag_mac_address = "CF:4A:3F:61:D0:41"  # Substitua pelo endereço MAC da sua tag RFID
battery_service_uuid = "0000180a-0000-1000-8000-00805f9b34fb"  # Substitua pelo UUID do serviço de bateria
battery_characteristic_uuid = "0000180f-0000-1000-8000-00805f9b34fb"  # Substitua pelo UUID da característica de nível de bateria

reader = RFIDBatteryReader(tag_mac_address, battery_service_uuid, battery_characteristic_uuid)
reader.start_reading()

