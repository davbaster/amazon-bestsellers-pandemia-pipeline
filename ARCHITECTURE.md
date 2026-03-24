# Architecture

## Data Engineering Architecture: Pandemic Trends

This project analyzes Amazon bestseller behavior across the pandemic era through a full DataOps workflow built on Bruin, Terraform, and GCP.

## Overview

The platform is designed to answer how book demand and category trends shifted before, during, and after COVID-19.

At a high level, the system will:

1. ingest source data into raw storage
2. standardize and clean records in staging models
3. create analytical fact tables for trend analysis
4. serve results to a Streamlit dashboard

## Technical Stack

- Orchestration: Bruin, a lightweight SQL-first orchestrator
- Infrastructure: Terraform with a dual-provider approach for GCP and Docker
- Storage: BigQuery for cloud execution and PostgreSQL for local execution
- CI/CD: GitHub Actions for automated testing and pipeline validation

## CI/CD Workflow

The repository includes [`.github/workflows/main.yml`](/home/admin/data-engineering/amz-bestsellers-la/.github/workflows/main.yml) to automate core validation tasks:

- run `bruin format --check` to enforce code quality
- execute `bruin dry-run` to validate SQL lineage
- run `terraform fmt -check -recursive` to enforce Terraform formatting

## Deployment Model

### Cloud

- Terraform provisions GCP resources such as storage, BigQuery datasets, and IAM bindings
- Bruin orchestrates ingestion and transformation tasks
- BigQuery stores analytical models used by the dashboard

### Local

- local assets can be stored under `pipeline/assets/`
- local infrastructure can use Docker-backed services under `infrastructure/local/`

## Naming Conventions

### Data Modeling

- `raw_` for source-aligned tables with no business transformations
- `stg_` for cleaned, typed, and standardized staging tables
- `fct_` for final analytical fact tables

### Infrastructure as Code

Terraform resource identifiers should use underscores.

Example:

```hcl
resource "google_storage_bucket" "data_lake" {
  name = "amazon-bestsellers-pandemia-data-lake"
}
```

### Orchestration

Bruin task names should describe the action they perform.

Examples:

- `ingest_kaggle`
- `transform_pandemic_trends`

## Data Layers

- `raw_` tables preserve source fidelity for reproducibility
- `stg_` tables normalize schemas, data types, and business logic inputs
- `fct_` tables support final analysis across pandemic eras

## Data Modeling Logic

The pipeline categorizes records into three distinct eras using a SQL transformation managed by Bruin.

### Era Definitions

- Pre-Pandemic: year values earlier than 2020
- During Pandemic: year values in 2020 and 2021
- Post-Pandemic: year values after the pandemic period in the final analytical model

### Transformation Snippet (Bruin SQL)

```sql
-- transformations/fct_pandemic_analysis.sql
SELECT
    name,
    author,
    genre,
    year,
    CASE
        WHEN year < 2020 THEN 'Pre-Pandemic'
        WHEN year BETWEEN 2020 AND 2021 THEN 'During Pandemic'
        ELSE 'Post-Pandemic'
    END AS pandemic_era,
    reviews,
    user_rating
FROM {{ ref('stg_bestsellers') }}
```

## Suggested Analytical Focus

- category shifts across eras
- changes in author concentration and repeat bestsellers
- differences in pricing, rankings, and review signals over time
- comparison of pre-pandemic, pandemic, and post-pandemic demand patterns
