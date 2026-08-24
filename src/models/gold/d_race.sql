WITH circuits AS (
    SELECT * FROM {{ ref('circuits') }}
)

, races AS (
    SELECT * FROM {{ ref('races') }}
)

SELECT
    races.raceid AS race_id
    , {{ generate_race_ref('races.season', 'races.round') }} AS race_ref
    , races.season AS race_season
    , races.round AS race_round
    , circuits.circuitref AS circuit_ref
    , races.race_name
    , races.url AS race_url
    , races.race_date
    , {{ date_time_to_timestamp('races.race_date', 'races.race_time') }} AS race_timestamp
    , races.fp1_date
    , {{ date_time_to_timestamp('races.fp1_date', 'races.fp1_time') }} AS fp1_timestamp
    , races.fp2_date
    , {{ date_time_to_timestamp('races.fp2_date', 'races.fp2_time') }} AS fp2_timestamp
    , races.fp3_date
    , {{ date_time_to_timestamp('races.fp3_date', 'races.fp3_time') }} AS fp3_timestamp
    , races.quali_date AS qualifying_date
    , {{ date_time_to_timestamp('races.quali_date', 'races.quali_time') }}
        AS qualifying_timestamp
    , races.sprint_date
    , {{ date_time_to_timestamp('races.sprint_date', 'races.sprint_time') }}
        AS sprint_timestamp
FROM races
LEFT JOIN circuits ON circuits.circuitid = races.circuitid
