-- Raw landing of circuits.csv from the UC Volume, no typing/renaming
select *
from read_files(
    '/Volumes/lake_dev/bronze/f1db_raw/circuits.csv'
    , format => 'csv'
    , header => true
    , nullValue => '\\N'
    , inferSchema => false
)
