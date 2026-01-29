import sqlite3
from pathlib import Path

DB_PATH = Path("data/olist.db")
SQL_PATH = Path("sql/01_create_fact_orders.sql")

conn = sqlite3.connect(DB_PATH)

with open(SQL_PATH, "r", encoding="utf-8") as f:
    sql_script = f.read()


conn.executescript(sql_script)
conn.close()

print("Query ejecutada correctamente")