{#-
    Combines a DATE column and a 'HH:mm:ss' time-of-day STRING column into a
    TIMESTAMP. CONCAT propagates NULL, so a missing date or time yields NULL.
#}
{% macro date_time_to_timestamp(date_column, time_column) -%}
    TO_TIMESTAMP(CONCAT(CAST({{ date_column }} AS STRING), ' ', {{ time_column }}))
{%- endmacro %}
