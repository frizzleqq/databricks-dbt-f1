with drivers as (
    select * from {{ ref('drivers') }}
)

, races as (
    select * from {{ ref('races') }}
)

, results as (
    select * from {{ ref('results') }}
)

, results_aggregated as (
    select
        results.driverid
        , min(races.race_date) as first_race_date
        , max(races.race_date) as most_recent_race_date
        , count(distinct results.raceid) as career_races
        , sum(results.points) as career_points
        , sum(results.laps) as career_laps
    from results
    inner join races on races.raceid = results.raceid
    group by results.driverid
)

select
    drivers.driverid as driver_id
    , drivers.driverref as driver_ref
    , drivers.surname as driver_second_name
    , drivers.forename as driver_first_name
    , concat(drivers.forename, ' ', drivers.surname) as driver_full_name
    , drivers.code as driver_code
    , drivers.driver_number
    , drivers.dob as driver_date_of_birth
    , drivers.nationality as driver_nationality
    , drivers.url as driver_url
    , results_aggregated.first_race_date
    , results_aggregated.most_recent_race_date
    , coalesce(results_aggregated.career_races, 0) as career_races
    , coalesce(results_aggregated.career_points, 0) as career_points
    , coalesce(results_aggregated.career_laps, 0) as career_laps
from drivers
left join results_aggregated on results_aggregated.driverid = drivers.driverid
