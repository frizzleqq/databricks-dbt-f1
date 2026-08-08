{{ config(unique_key='statusid') }}

select
    statusid
    , status
from {{ ref('ergast_status') }}
