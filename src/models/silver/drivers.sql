{{ config(unique_key='driverid') }}

select
    driverid
    , driverref
    , cast(number as int) as driver_number
    , code
    , forename
    , surname
    , cast(dob as date) as dob
    , nationality
    , url
from {{ ref('ergast_drivers') }}
