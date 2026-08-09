select *
from read_files(
    '/Volumes/lake_dev/bronze/f1db_raw/drivers.csv'
    , format => 'csv'
    , header => true
    , nullValue => '\\N'
    , inferSchema => false
)
