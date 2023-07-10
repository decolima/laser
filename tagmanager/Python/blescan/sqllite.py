import os
import sqlite3

class SQLiteClient:
    def __init__(self, database_name):
        current_directory = os.getcwd()
        self.database_path = os.path.join(current_directory, database_name)
        self.conn = None
        self.cursor = None

    def connect(self):
        self.conn = sqlite3.connect(self.database_path)
        self.cursor = self.conn.cursor()

    def execute_query(self, query, params=None):
        if not self.conn:
            self.connect()
        if params:
            self.cursor.execute(query, params)
        else:
            self.cursor.execute(query)
        rows = self.cursor.fetchall()
        return rows

    def execute_command(self, command, params=None):
        if not self.conn:
            self.connect()
        if params:
            self.cursor.execute(command, params)
        else:
            self.cursor.execute(command)
        self.conn.commit()
        
    def create_table(self, table_name, columns):
        if not self.conn:
            self.connect()
        self.cursor.execute(f"CREATE TABLE IF NOT EXISTS {table_name} ({columns})")
        self.conn.commit()

    def close(self):
        if self.conn:
            self.conn.close()
            self.conn = None
            self.cursor = None
