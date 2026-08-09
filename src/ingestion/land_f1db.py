"""Downloads the F1 (Ergast) dataset zip and lands its CSV members into the bronze UC Volume."""

import io
import urllib.request
import zipfile
from pathlib import Path

ZIP_URL = "https://raw.githubusercontent.com/frizzleqq/f1-dbt-duckdb/main/f1db/f1db_csv.zip"
VOLUME_PATH = "/Volumes/lake_dev/bronze/f1db_raw"
TABLES = [
    "circuits",
    "constructor_results",
    "constructor_standings",
    "constructors",
    "driver_standings",
    "drivers",
    "lap_times",
    "pit_stops",
    "qualifying",
    "races",
    "results",
    "seasons",
    "status",
]

with urllib.request.urlopen(ZIP_URL) as response:
    zip_bytes = response.read()

with zipfile.ZipFile(io.BytesIO(zip_bytes)) as zf:
    for table in TABLES:
        with zf.open(f"{table}.csv") as member:
            data = member.read()
        with Path(f"{VOLUME_PATH}/{table}.csv").open("wb") as f:
            f.write(data)
        print(f"Landed {table}.csv ({len(data)} bytes)")
