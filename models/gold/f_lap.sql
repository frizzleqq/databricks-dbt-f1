with lap_times as (
    select * from {{ ref('lap_times') }}
)

, d_driver as (
    select * from {{ ref('d_driver') }}
)

, d_race as (
    select * from {{ ref('d_race') }}
)

, joined as (
    select
        d_race.race_ref
        , d_race.race_date
        , d_driver.driver_ref
        , lap_times.lap as lap_number
        , lap_times.race_position
        , lap_times.lap_time
        , lap_times.lap_milliseconds
    from lap_times
    left join d_driver
        on d_driver.driver_id = lap_times.driverid
    left join d_race
        on d_race.race_id = lap_times.raceid
)

select
    {{
        dbt_utils.generate_surrogate_key([
            'race_ref',
            'driver_ref',
            'lap_number',
        ])
    }} as lap_ref
    , *
from joined
