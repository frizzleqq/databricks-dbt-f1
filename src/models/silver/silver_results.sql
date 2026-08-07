{{ config(unique_key='resultid') }}

select
    resultid
    , raceid
    , driverid
    , constructorid
    , cast(number as int) as driver_number
    , cast(grid as int) as grid
    , cast(position as int) as result_position
    , positiontext
    , cast(positionorder as int) as positionorder
    , cast(points as double) as points
    , cast(laps as int) as laps
    , time
    , cast(milliseconds as bigint) as milliseconds
    , fastestlap
    , cast(rank as int) as fastestlap_rank
    , fastestlaptime
    , cast(fastestlapspeed as double) as fastestlapspeed
    , statusid
from {{ ref('bronze_results') }}
