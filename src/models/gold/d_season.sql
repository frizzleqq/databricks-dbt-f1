select
    season
    , url as season_url
from {{ ref('silver_seasons') }}
