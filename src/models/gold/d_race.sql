with circuits as (
    select * from {{ ref('circuits') }}
)

, races as (
    select * from {{ ref('races') }}
)

select
    races.raceid as race_id
    , concat(races.season, '-', races.round) as race_ref
    , races.season as race_season
    , races.round as race_round
    , circuits.circuitref as circuit_ref
    , races.race_name
    , races.url as race_url
    , races.race_date
    , to_timestamp(concat(cast(races.race_date as string), ' ', races.race_time)) as race_timestamp
    , races.fp1_date
    , to_timestamp(concat(cast(races.fp1_date as string), ' ', races.fp1_time)) as fp1_timestamp
    , races.fp2_date
    , to_timestamp(concat(cast(races.fp2_date as string), ' ', races.fp2_time)) as fp2_timestamp
    , races.fp3_date
    , to_timestamp(concat(cast(races.fp3_date as string), ' ', races.fp3_time)) as fp3_timestamp
    , races.quali_date as qualifying_date
    , to_timestamp(concat(cast(races.quali_date as string), ' ', races.quali_time)) as qualifying_timestamp
    , races.sprint_date
    , to_timestamp(concat(cast(races.sprint_date as string), ' ', races.sprint_time)) as sprint_timestamp
from races
left join circuits on circuits.circuitid = races.circuitid
