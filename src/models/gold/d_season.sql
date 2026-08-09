SELECT
    season
    , url AS season_url
FROM {{ ref('seasons') }}
