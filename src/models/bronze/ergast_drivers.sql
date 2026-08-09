SELECT *
FROM READ_FILES(
    '/Volumes/lake_dev/bronze/f1db_raw/drivers.csv'
    , format => 'csv'
    , header => TRUE
    , nullValue => '\\N'
    , inferSchema => FALSE
)
