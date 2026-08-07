{{ config(unique_key='season') }}

select
    cast(year as int) as season
    , url
from {{ ref('bronze_seasons') }}
