WITH circuits AS (
    SELECT * FROM {{ ref('circuits') }}
)

, races AS (
    SELECT * FROM {{ ref('races') }}
)

SELECT
    races.raceid AS race_id
    , CONCAT(races.season, '-', races.round) AS race_ref
    , races.season AS race_season
    , races.round AS race_round
    , circuits.circuitref AS circuit_ref
    , races.race_name
    , races.url AS race_url
    , races.race_date
    , TO_TIMESTAMP(CONCAT(CAST(races.race_date AS STRING), ' ', races.race_time)) AS race_timestamp
    , races.fp1_date
    , TO_TIMESTAMP(CONCAT(CAST(races.fp1_date AS STRING), ' ', races.fp1_time)) AS fp1_timestamp
    , races.fp2_date
    , TO_TIMESTAMP(CONCAT(CAST(races.fp2_date AS STRING), ' ', races.fp2_time)) AS fp2_timestamp
    , races.fp3_date
    , TO_TIMESTAMP(CONCAT(CAST(races.fp3_date AS STRING), ' ', races.fp3_time)) AS fp3_timestamp
    , races.quali_date AS qualifying_date
    , TO_TIMESTAMP(CONCAT(CAST(races.quali_date AS STRING), ' ', races.quali_time))
        AS qualifying_timestamp
    , races.sprint_date
    , TO_TIMESTAMP(CONCAT(CAST(races.sprint_date AS STRING), ' ', races.sprint_time))
        AS sprint_timestamp
FROM races
LEFT JOIN circuits ON circuits.circuitid = races.circuitid
