with results as (
    select * from {{ ref('results') }}
)

, constructor_standings as (
    select * from {{ ref('constructor_standings') }}
)

, driver_standings as (
    select * from {{ ref('driver_standings') }}
)

, qualifying as (
    select * from {{ ref('qualifying') }}
)

, result_status as (
    select * from {{ ref('status') }}
)

, d_circuit as (
    select * from {{ ref('d_circuit') }}
)

, d_constructor as (
    select * from {{ ref('d_constructor') }}
)

, d_driver as (
    select * from {{ ref('d_driver') }}
)

, d_race as (
    select * from {{ ref('d_race') }}
)

, joined as (
    select
        d_race.race_date
        , d_race.race_ref
        , d_circuit.circuit_ref
        , d_constructor.constructor_ref
        , d_driver.driver_ref
        , results.driver_number
        , results.grid as starting_position
        , results.result_position
        , results.positiontext as result_position_text
        , results.positionorder as result_position_order
        , results.points as result_points
        , result_status.status as result_status
        , results.laps as laps_completed
        , results.time as finishing_time
        , results.milliseconds as finishing_time_milliseconds
        , coalesce(results.fastestlap_rank = 1, false) as has_fastest_lap
        , results.fastestlap as fastest_lap_number
        , results.fastestlap_rank as fastest_lap_position
        , results.fastestlaptime as fastest_lap_time
        , results.fastestlapspeed as fastest_lap_avg_speed
        , qualifying.qualifying_position
        , qualifying.q1 as qualifying1_lap_time
        , qualifying.q2 as qualifying2_lap_time
        , qualifying.q3 as qualifying3_lap_time
        , driver_standings.points as driver_season_points
        , driver_standings.driver_position as driver_season_position
        , driver_standings.positiontext as driver_season_position_text
        , driver_standings.wins as driver_season_wins
        , constructor_standings.points as constructor_season_points
        , constructor_standings.constructor_position as constructor_season_position
        , constructor_standings.positiontext as constructor_season_position_text
        , constructor_standings.wins as constructor_season_wins
    from results
    left join result_status on result_status.statusid = results.statusid
    left join constructor_standings
        on
            constructor_standings.raceid = results.raceid
            and constructor_standings.constructorid = results.constructorid
    left join driver_standings
        on driver_standings.raceid = results.raceid and driver_standings.driverid = results.driverid
    left join qualifying
        on qualifying.raceid = results.raceid and qualifying.driverid = results.driverid
    left join d_race
        on d_race.race_id = results.raceid
    left join d_circuit
        on d_circuit.circuit_ref = d_race.circuit_ref
    left join d_constructor
        on d_constructor.constructor_id = results.constructorid
    left join d_driver
        on d_driver.driver_id = results.driverid
)

select
    {{
        dbt_utils.generate_surrogate_key([
            'race_ref',
            'driver_ref',
        ])
    }} as result_ref
    , *
from joined
