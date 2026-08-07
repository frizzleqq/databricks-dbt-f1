with pitstops as (
    select * from {{ ref('silver_pit_stops') }}
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
        , pitstops.pitstop_number
        , pitstops.lap as lap_number
        , to_timestamp(concat(cast(d_race.race_date as string), ' ', pitstops.pitstop_time)) as pitstop_timestamp
        , pitstops.duration as pitstop_duration
        , cast(pitstops.milliseconds as double) / 1000 as pitstop_seconds
    from pitstops
    left join d_driver
        on d_driver.driver_id = pitstops.driverid
    left join d_race
        on d_race.race_id = pitstops.raceid
)

select
    {{
        dbt_utils.generate_surrogate_key([
            'race_ref',
            'driver_ref',
            'pitstop_number',
        ])
    }} as pitstop_ref
    , *
from joined
