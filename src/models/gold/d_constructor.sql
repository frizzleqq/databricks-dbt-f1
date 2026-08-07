select
    constructorid as constructor_id
    , constructorref as constructor_ref
    , constructor_name
    , nationality as constructor_nationality
    , url as constructor_url
from {{ ref('constructors') }}
