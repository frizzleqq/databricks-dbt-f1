{{ config(unique_key='circuitid') }}

select
    circuitid
    , circuitref
    , name as circuit_name
    , location
    , country
    , cast(lat as double) as lat
    , cast(lng as double) as lng
    , url
from {{ ref('ergast_circuits') }}
