select
    circuitid as circuit_id
    , circuitref as circuit_ref
    , circuit_name
    , location as circuit_location
    , country as circuit_country
    , url as circuit_url
    , lat as circuit_latitude
    , lng as circuit_longitude
from {{ ref('circuits') }}
