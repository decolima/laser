import pygatt


class BLEScanner:
    def __init__(self):
        self.adapter = pygatt.GATTToolBackend()

    def scan(self, duration=10):
        self.adapter.start()
        devices = self.adapter.scan(timeout=duration)
        self.adapter.stop()
        return devices


# Exemplo de uso
scanner = BLEScanner()
devices = scanner.scan()
for device in devices:
    print(f"Device: {device['address']} - {device['name']}")
