{{ config(unique_key='constructorid') }}

SELECT
    constructorid
    , constructorref
    , name AS constructor_name
    , nationality
    , url
FROM {{ ref('ergast_constructors') }}
