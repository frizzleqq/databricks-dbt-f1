{{ config(unique_key='statusid') }}

select
    statusid
    , status
from {{ ref('bronze_status') }}
