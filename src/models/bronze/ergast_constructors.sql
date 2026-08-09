SELECT *
FROM READ_FILES(
    '/Volumes/lake_dev/bronze/f1db_raw/constructors.csv'
    , format => 'csv'
    , header => TRUE
    , nullValue => '\\N'
    , inferSchema => FALSE
)
