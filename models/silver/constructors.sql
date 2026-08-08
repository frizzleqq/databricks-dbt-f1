{{ config(unique_key='constructorid') }}

select
    constructorid
    , constructorref
    , name as constructor_name
    , nationality
    , url
from {{ ref('ergast_constructors') }}
