SELECT *
FROM READ_FILES(
    '/Volumes/lake_dev/bronze/f1db_raw/driver_standings.csv'
    , format => 'csv'
    , header => TRUE
    , nullValue => '\\N'
    , inferSchema => FALSE
)
