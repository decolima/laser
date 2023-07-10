from datetime import datetime
import time
from blescan import ScanDevices

class Main:
    def main(self):
        scan = ScanDevices()
        
        while True:
            current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            print("Esecuzione ad :", current_time)
            scan.run()
            current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            print("Finale Esecuzione ad :", current_time)
            time.sleep(300)

# Criar uma instância da classe Main
my_main = Main()

# Chamar o método main
my_main.main()
