select *
from read_files(
    '/Volumes/lake_dev/bronze/f1db_raw/driver_standings.csv',
    format => 'csv',
    header => true,
    nullValue => '\\N',
    inferSchema => false
)
