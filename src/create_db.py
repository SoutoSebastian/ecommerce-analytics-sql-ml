import pandas as pd
import sqlite3
from pathlib import Path

DATA_RAW = Path("data/raw")
DB_PATH = Path("data/olist.db")

conn = sqlite3.connect(DB_PATH)

for csv_file in DATA_RAW.glob("*.csv"):
    table_name = csv_file.stem
    df = pd.read_csv(csv_file)

    df.to_sql(
        table_name,
        conn,
        if_exists = "replace",
        index = False
    )

    print(f"Tabla cargada: {table_name}")


conn.close()

print("Base de datos creada con todas las tablas raw")

