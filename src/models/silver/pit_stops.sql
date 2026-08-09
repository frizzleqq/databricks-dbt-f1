{{ config(unique_key=['raceid', 'driverid', 'pitstop_number']) }}

SELECT
    raceid
    , driverid
    , CAST(stop AS INT) AS pitstop_number
    , CAST(lap AS INT) AS lap
    , CAST(time AS STRING) AS pitstop_time
    , duration
    , CAST(milliseconds AS BIGINT) AS milliseconds
FROM {{ ref('ergast_pit_stops') }}
