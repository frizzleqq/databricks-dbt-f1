select
    season
    , url as season_url
from {{ ref('seasons') }}
