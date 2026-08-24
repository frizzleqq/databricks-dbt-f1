{#-
    Builds the human-readable race business key '<season>-<round>'
    (e.g. '2021-5'). CONCAT propagates NULL, so a missing season or
    round yields NULL.
#}
{% macro generate_race_ref(season_column, round_column) -%}
    CONCAT({{ season_column }}, '-', {{ round_column }})
{%- endmacro %}
