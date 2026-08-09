{{ config(unique_key='statusid') }}

SELECT
    statusid
    , status
FROM {{ ref('ergast_status') }}
