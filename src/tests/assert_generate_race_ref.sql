-- Macro-only test for generate_race_ref(): runs the macro over literal
-- inputs (no models or source tables involved) and fails on any case row
-- where the macro output differs from the expected race_ref.
WITH cases AS (
    SELECT
        'season and round combine' AS case_name
        , CAST(2021 AS INT) AS input_season
        , CAST(5 AS INT) AS input_round
        , '2021-5' AS expected_race_ref

    UNION ALL

    SELECT
        'NULL round yields NULL' AS case_name
        , CAST(2021 AS INT) AS input_season
        , NULL AS input_round
        , NULL AS expected_race_ref

    UNION ALL

    SELECT
        'NULL season yields NULL' AS case_name
        , NULL AS input_season
        , CAST(5 AS INT) AS input_round
        , NULL AS expected_race_ref
)

, evaluated AS (
    SELECT
        case_name
        , input_season
        , input_round
        , expected_race_ref
        , {{ generate_race_ref('input_season', 'input_round') }} AS actual_race_ref
    FROM cases
)

SELECT *
FROM evaluated
WHERE NOT (actual_race_ref <=> expected_race_ref)
