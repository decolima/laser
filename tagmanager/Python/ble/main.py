import time
import asyncio
from bleak import BleakScanner

async def search():
    scanner = BleakScanner()
    devices = await scanner.discover()
    return devices

# Programa principal
while True:
    print("[SCAN] Scan BLE sendo realizado. Aguarde...")
    results = asyncio.run(search())
    print("[SCAN] Fim do scan BLE.")
    if results:
        for device in results:
            addr = device.address
            name = device.name
            print("Dispositivo encontrado: {0} - {1}".format(addr, name))
    time.sleep(1)
    print(" ")