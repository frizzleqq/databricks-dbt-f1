{{ config(unique_key=['raceid', 'driverid', 'pitstop_number']) }}

select
    raceid
    , driverid
    , cast(stop as int) as pitstop_number
    , cast(lap as int) as lap
    , cast(time as string) as pitstop_time
    , duration
    , cast(milliseconds as bigint) as milliseconds
from {{ ref('bronze_pit_stops') }}
