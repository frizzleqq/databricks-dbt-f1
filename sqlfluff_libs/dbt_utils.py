"""Stubs for the `dbt_utils` macros used by our models.

sqlfluff lints the models with the plain `jinja` templater (no warehouse
connection required), so macros from dbt packages are not available. Every
module in this directory is exposed to the templater as a Jinja namespace,
which lets `{{ dbt_utils.generate_surrogate_key([...]) }}` render to valid SQL.

The rendered SQL only has to parse - it is never executed - so the stubs mimic
the shape of the real macros rather than their exact implementation.
"""


def generate_surrogate_key(field_list: list[str]) -> str:
    """Render a stand-in for `dbt_utils.generate_surrogate_key`.

    Args:
        field_list: Columns/expressions the surrogate key is built from.

    Returns:
        A SQL expression hashing the concatenation of the given fields.
    """
    fields = ", ".join(f"coalesce(cast({field} as string), '')" for field in field_list)
    return f"md5(concat_ws('-', {fields}))"
