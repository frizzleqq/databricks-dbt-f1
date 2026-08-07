{{ config(unique_key='constructorresultsid') }}

select
    constructorresultsid
    , raceid
    , constructorid
    , points as constructor_points
    , status
from {{ ref('ergast_constructor_results') }}
