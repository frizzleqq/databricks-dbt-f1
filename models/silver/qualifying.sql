{{ config(unique_key='qualifyid') }}

select
    qualifyid
    , raceid
    , driverid
    , constructorid
    , cast(number as int) as driver_number
    , cast(position as int) as qualifying_position
    , q1
    , q2
    , q3
from {{ ref('ergast_qualifying') }}
