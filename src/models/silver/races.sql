{{ config(unique_key='raceid') }}

select
    raceid
    , cast(year as int) as season
    , cast(round as int) as round
    , circuitid
    , name as race_name
    , cast(date as date) as race_date
    , cast(time as string) as race_time
    , url
    , cast(fp1_date as date) as fp1_date
    , cast(fp1_time as string) as fp1_time
    , cast(fp2_date as date) as fp2_date
    , cast(fp2_time as string) as fp2_time
    , cast(fp3_date as date) as fp3_date
    , cast(fp3_time as string) as fp3_time
    , cast(quali_date as date) as quali_date
    , cast(quali_time as string) as quali_time
    , cast(sprint_date as date) as sprint_date
    , cast(sprint_time as string) as sprint_time
from {{ ref('ergast_races') }}
