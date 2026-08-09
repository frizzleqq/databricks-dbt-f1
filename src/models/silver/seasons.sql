{{ config(unique_key='season') }}

SELECT
    CAST(year AS INT) AS season
    , url
FROM {{ ref('ergast_seasons') }}
