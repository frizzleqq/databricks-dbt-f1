This file provides guidance to AI assistants when working with code in this repository.

# Project Overview

This repo deploys a Databricks Automation Bundle (DAB) with a dbt project.

## Project Structure
- `databricks.yml`: DAB configuration file
- `dbt_project.yml`: dbt configuration file
- `src/`:  source code
  - `src/ingestion/`: Python Code for data ingestion.
  - `src/macros/`: dbt Macros
  - `src/models/`: dbt Models
- `resources/`: DAB Resource configurations (jobs, pipelines, UC schemas, volumes, alerts)
- `tests/`: Unit tests for the shared Python code.

## Setup commands
- Setup environment: `uv sync --locked`
- DAB commands: `databricks bundle ...`
- dbt commands: `uv run dbt ...`
- Deploy to dev: `databricks bundle deploy --target dev`
  - For target dev deployed jobs are prefixed with [dev_${workspace.current_user.short_name}]
- Run Python code checks: `uv run ruff check --fix`
- Check Python code formatting: `uv run ruff format`
- Run Python tests: `uv run pytest -v`

## Code Style
- Google Python Style Guide
- Include type hints
- Keep imports at top of the file
- To import PySpark types/functions use `from pyspark.sql import functions as F, types as T`

## Data Structure
- Catalogs: `lake_dev` (dev, default), `lake_test` (test), `lake_prod` (prod)
- Schemas for tables: `bronze`, `silver`, `gold`

## Naming Conventions
- Dimension tables: `dim_` prefix, `_a` suffix (SCD1/current) or `_h` suffix (SCD2/history)
- Fact tables: `fact_` prefix
- Surrogate keys: `_sk` suffix