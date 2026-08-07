{{ config(unique_key=['raceid', 'driverid', 'lap']) }}

select
    raceid
    , driverid
    , cast(lap as int) as lap
    , cast(position as int) as race_position
    , time as lap_time
    , cast(milliseconds as bigint) as lap_milliseconds
from {{ ref('bronze_lap_times') }}
