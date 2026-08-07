{{ config(unique_key='constructorresultsid') }}

select
    constructorresultsid
    , raceid
    , constructorid
    , points as constructor_points
    , status
from {{ ref('bronze_constructor_results') }}
