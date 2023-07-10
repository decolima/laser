#classe utilizzata per realizare il salvataggio delle informazione dello scanner nel database
import sqlite3
from datetime import datetime
from sqllite import SQLiteClient

class ScanDeviceManager:
    @staticmethod
    def save_scan_devices(mac_addresses):
        db_name = "blescan.db"
        sqlite_client = SQLiteClient(db_name)
        
        for mac_address in mac_addresses:
            scan_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            status = 0
            command = "INSERT INTO scan_devices (mac_address, scan_date, status) VALUES (?, ?, ?)"
            #print(mac_address.address)
            params = (mac_address.address, scan_date, status)
            sqlite_client.execute_command(command, params)
            
        query = "SELECT * FROM scan_devices"
        results = sqlite_client.execute_query(query)
        for row in results:
            print(row)
        
        sqlite_client.close()
