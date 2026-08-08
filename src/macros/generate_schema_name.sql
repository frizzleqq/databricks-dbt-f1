{#-
    dbt otherwise concatenates the profile's target schema with a model's
    custom +schema as '<target_schema>_<custom_schema>'. This macro makes
    the custom schema (bronze/silver/gold) the literal schema name.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
