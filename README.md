# Databricks-dbt-f1

This project is a showcase of a Databricks Automation Bundle that deploys a `dbt` project

* `src/`: Python and dbt source code.
* `resources/`: Resource configurations (jobs, pipelines, UC schemas, volumes, alerts)

## Development

### Requirements

* uv: https://docs.astral.sh/uv/getting-started/installation/
* Databricks CLI: https://docs.databricks.com/aws/en/dev-tools/cli/install
* (Optional) AI agent tooling: see [AI agent setup](#ai-agent-setup-optional)

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

### AI agent setup (optional)

Skills, plugins, and MCP servers are installed per developer and per checkout.
The resulting configuration is not checked in (`.claude/skills/databricks-*`
and `.claude/settings.local.json` are git-ignored), so run these steps once
after cloning.

#### Databricks AI skills

Installs the Databricks skills into `.claude/skills/`:

```bash
databricks aitools install --scope project --skills "databricks-core,databricks-dabs,databricks-docs,databricks-execution-compute,databricks-jobs,databricks-python-sdk,databricks-unity-catalog"
```

#### dbt plugins (Claude Code)

The [dbt Agent skills](https://github.com/dbt-labs/dbt-agent-skills) are
distributed as Claude Code plugins. Register the marketplace once per machine,
then enable the plugins for this checkout:

```bash
# once per machine
claude plugin marketplace add dbt-labs/dbt-agent-skills
# once per checkout
claude plugin install dbt@dbt-agent-marketplace --scope local
```

#### dbt MCP server

The [dbt MCP server](https://docs.getdbt.com/docs/dbt-ai/about-mcp) gives
agents structured access to dbt CLI commands (run, build, test, show).
Register it with Claude Code using the `local` scope — the required paths are
machine-specific, so the configuration should not be shared:

```bash
claude mcp add dbt --scope local \
  --env DBT_PROJECT_DIR=/absolute/path/to/this/repo \
  --env DBT_PATH=/absolute/path/to/this/repo/.venv/bin/dbt \
  -- uvx dbt-mcp
```

After `uv sync`, the dbt executable is at `.venv/bin/dbt` (macOS/Linux) or
`.venv\Scripts\dbt.exe` (Windows). The server itself is fetched and run via
`uvx`, so no extra installation is needed. Verify the connection with
`claude mcp list` or by asking the agent "What dbt tools do you have access to?".

### Python Checks

```bash
# Linting
uv run ruff check --fix
# Formatting
uv run ruff format
# Tests
uv run pytest -v
```

Ruff is configured in `pyproject.toml`.

### SQL Checks

SQL (dbt models and macros) is linted and formatted with
[sqlfluff](https://docs.sqlfluff.com/) using the `databricks` dialect:

```bash
# Linting
uv run sqlfluff lint src
# Formatting (rewrites files in place)
uv run sqlfluff fix src
```

The rules live in `.sqlfluff`: upper case keywords, functions and datatypes,
lower case identifiers, 4-space indents, leading commas, and a 100-character
line limit.

sqlfluff uses the plain `jinja` templater, so linting needs neither a dbt profile
nor a warehouse connection. `ref()`, `source()`, `config()` and friends come from
sqlfluff's dbt builtins; macros from dbt packages are stubbed in `sqlfluff_libs/`
(currently only `dbt_utils.generate_surrogate_key`). Add a stub there when a model
starts using another package macro.

Both checks run in CI alongside `dbt deps`/`dbt parse` in the `checks` job
(`.github/workflows/ci.yml`).

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
