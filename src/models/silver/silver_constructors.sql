{{ config(unique_key='constructorid') }}

select
    constructorid
    , constructorref
    , name as constructor_name
    , nationality
    , url
from {{ ref('bronze_constructors') }}
