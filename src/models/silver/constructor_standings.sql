{{ config(unique_key='constructorstandingsid') }}

SELECT
    constructorstandingsid
    , raceid
    , constructorid
    , CAST(points AS DOUBLE) AS points
    , CAST(position AS INT) AS constructor_position
    , positiontext
    , CAST(wins AS INT) AS wins
FROM {{ ref('ergast_constructor_standings') }}
