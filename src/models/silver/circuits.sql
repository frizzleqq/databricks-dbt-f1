{{ config(unique_key='circuitid') }}

SELECT
    circuitid
    , circuitref
    , name AS circuit_name
    , location
    , country
    , CAST(lat AS DOUBLE) AS lat
    , CAST(lng AS DOUBLE) AS lng
    , url
FROM {{ ref('ergast_circuits') }}
