# Databricks-dbt-f1

This project is a showcase of a Databricks Automation Bundle that deploys a `dbt` project

* `src/`: Python and dbt source code.
* `resources/`: Resource configurations (jobs, pipelines, UC schemas, volumes, alerts)

## Development

### Requirements

* uv: https://docs.astral.sh/uv/getting-started/installation/
* Databricks CLI: https://docs.databricks.com/aws/en/dev-tools/cli/install
* (Optional) AI Agents:
  * Databricks AI skills:
    ```bash
    databricks aitools install --scope project --skills "databricks-core,databricks-dabs,databricks-docs,databricks-execution-compute,databricks-jobs,databricks-python-sdk,databricks-unity-catalog"
    ```
  * dbt Agent skills: https://github.com/dbt-labs/dbt-agent-skills
  * dbt MCP Server: https://docs.getdbt.com/docs/dbt-ai/about-mcp
    ```bash
    uvx dbt-mcp
    ```


### Getting started

Sync `uv` environment:
```bash
uv sync
```

Initialize your dbt profile

```bash
uv run dbt init
```

Note that dbt authentication uses personal access tokens by default
(see https://docs.databricks.com/dev-tools/auth/pat.html).
You can use OAuth as an alternative, but this currently requires manual configuration.
See https://github.com/databricks/dbt-databricks/blob/main/docs/oauth.md
for general instructions, or https://community.databricks.com/t5/technical-blog/using-dbt-core-with-oauth-on-azure-databricks/ba-p/46605
for advice on setting up OAuth for Azure Databricks.

### Python Checks

```bash
# Linting
uv run ruff check --fix
# Formatting
uv run ruff format
# Tests
uv run pytest -v
```

### Local development with dbt

```
$ uv run dbt debug
$ uv run dbt run
$ uv run dbt test
```

## Production setup

Your production dbt profiles are defined in `dbt_profiles/profiles.yml`.
These profiles define the default warehouse, catalog, schema, and any other
target-specific settings. Read more about dbt profiles on Databricks at
https://docs.databricks.com/en/workflows/jobs/how-to/use-dbt-in-workflows.html#advanced-run-dbt-with-a-custom-profile.

The target workspaces for staging and prod are defined in `databricks.yml`.
You can manually deploy based on these configurations (see below).
Or you can use CI/CD to automate deployment. See
https://docs.databricks.com/dev-tools/bundles/ci-cd.html for documentation
on CI/CD setup.

## Manually deploying to Databricks with Declarative Automation Bundles

Declarative Automation Bundles can be used to deploy to Databricks and to execute
dbt commands as a job using Databricks Jobs. See
https://docs.databricks.com/dev-tools/bundles/index.html to learn more.

Use the Databricks CLI to deploy a development copy of this project to a workspace:

```
$ databricks bundle deploy --target dev
```

(Note that "dev" is the default target, so the `--target` parameter
is optional here.)

This deploys everything that's defined for this project.
For example, the default template would deploy a job called
`[dev yourname] databricks_dbt_f1_job` to your workspace.
You can find that job by opening your workpace and clicking on **Jobs & Pipelines**.

You can also deploy to your production target directly from the command-line.
The warehouse, catalog, and schema for that target are configured in `dbt_profiles/profiles.yml`.
When deploying to this target, note that the default job at resources/databricks_dbt_f1.job.yml
has a schedule set that runs every day. The schedule is paused when deploying in development mode
(see https://docs.databricks.com/dev-tools/bundles/deployment-modes.html).

To deploy a production copy, type:

```
$ databricks bundle deploy --target prod
```
