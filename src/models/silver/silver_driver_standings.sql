{{ config(unique_key='driverstandingsid') }}

select
    driverstandingsid
    , raceid
    , driverid
    , cast(points as double) as points
    , cast(position as int) as driver_position
    , positiontext
    , cast(wins as int) as wins
from {{ ref('bronze_driver_standings') }}
