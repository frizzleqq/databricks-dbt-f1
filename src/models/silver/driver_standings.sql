{{ config(unique_key='driverstandingsid') }}

SELECT
    driverstandingsid
    , raceid
    , driverid
    , CAST(points AS DOUBLE) AS points
    , CAST(position AS INT) AS driver_position
    , positiontext
    , CAST(wins AS INT) AS wins
FROM {{ ref('ergast_driver_standings') }}
