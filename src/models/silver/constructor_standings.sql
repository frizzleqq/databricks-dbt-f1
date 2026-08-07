{{ config(unique_key='constructorstandingsid') }}

select
    constructorstandingsid
    , raceid
    , constructorid
    , cast(points as double) as points
    , cast(position as int) as constructor_position
    , positiontext
    , cast(wins as int) as wins
from {{ ref('ergast_constructor_standings') }}
