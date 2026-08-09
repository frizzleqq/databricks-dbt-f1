-- Raw landing of circuits.csv from the UC Volume, no typing/renaming
SELECT *
FROM READ_FILES(
    '/Volumes/lake_dev/bronze/f1db_raw/circuits.csv'
    , format => 'csv'
    , header => TRUE
    , nullValue => '\\N'
    , inferSchema => FALSE
)
