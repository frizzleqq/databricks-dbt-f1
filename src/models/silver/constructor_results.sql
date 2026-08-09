{{ config(unique_key='constructorresultsid') }}

SELECT
    constructorresultsid
    , raceid
    , constructorid
    , points AS constructor_points
    , status
FROM {{ ref('ergast_constructor_results') }}
