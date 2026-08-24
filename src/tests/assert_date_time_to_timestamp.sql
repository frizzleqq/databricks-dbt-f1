-- Macro-only test for date_time_to_timestamp(): runs the macro over literal
-- inputs (no models or source tables involved) and fails on any case row
-- where the macro output differs from the expected timestamp.
WITH cases AS (
    SELECT
        'date and time combine' AS case_name
        , CAST('2021-05-23' AS DATE) AS input_date
        , '13:00:00' AS input_time
        , CAST('2021-05-23 13:00:00' AS TIMESTAMP) AS expected_timestamp

    UNION ALL

    SELECT
        'NULL time yields NULL' AS case_name
        , CAST('2021-05-23' AS DATE) AS input_date
        , NULL AS input_time
        , NULL AS expected_timestamp

    UNION ALL

    SELECT
        'NULL date yields NULL' AS case_name
        , NULL AS input_date
        , '13:00:00' AS input_time
        , NULL AS expected_timestamp
)

, evaluated AS (
    SELECT
        case_name
        , input_date
        , input_time
        , expected_timestamp
        , {{ date_time_to_timestamp('input_date', 'input_time') }} AS actual_timestamp
    FROM cases
)

SELECT *
FROM evaluated
WHERE NOT (actual_timestamp <=> expected_timestamp)
