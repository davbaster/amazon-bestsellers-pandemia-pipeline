# amazon-bestsellers-pandemia-pipeline

This project builds a full DataOps pipeline to analyze how global book trends shifted before, during, and after the COVID-19 pandemic using Bruin, Terraform, and GCP.

## Quick Start

### Cloud Deployment

#### 1. Prerequisites

- Install Terraform
- Install Bruin CLI
- Create or use an existing GCP project
- Download a GCP service account JSON key and save it as `service-account.json`

#### 2. Infrastructure Setup

```bash
cd infrastructure/gcp
terraform init
terraform apply -var="project_id=amz-bestseller-pandemia" -var="region=us-central1"
```

#### 3. Run the Pipeline

```bash
# Setup your Bruin environment
bruin init

# Run the ingestion and transformation
bruin run
```

#### 4. Launch Dashboard

```bash
pip install streamlit
streamlit run dashboard/app.py
```

### Local Execution (Optional)

If you do not want to use GCP, use the local Docker environment:

```bash
cd infrastructure/local
terraform init
terraform apply
make infra-local
make pipeline
```

The expected cloud workflow is:

1. Provision infrastructure on GCP with Terraform
2. Run Bruin ingestion and transformation tasks
3. Query the final tables and expose results in the dashboard

## Naming Conventions

### Tables

- `raw_`: untouched data from source
- `stg_`: cleaned and casted staging data
- `fct_`: final analysis tables

### Terraform

Resource names use underscores, for example `google_storage_bucket.data_lake`.

### Bruin

Tasks are named by action, for example `ingest_kaggle` and `transform_pandemic_trends`.

## Structure

```text
amazon-bestsellers-pandemia-pipeline
├── .github/workflows/
├── infrastructure/
│   ├── gcp/
│   └── local/
├── pipeline/
│   ├── assets/
│   ├── ingestion/
│   └── transformations/
├── dashboard/
├── Makefile
├── README.md
└── ARCHITECTURE.md
```

## Project Theme

The analysis focuses on how Amazon bestseller patterns changed across three eras:

- pre-pandemic
- pandemic
- post-pandemic

The pipeline will support loading raw source data, standardizing it into staging models, and producing analytical fact tables for downstream reporting.

## CI/CD

The project includes [`.github/workflows/main.yml`](/home/admin/data-engineering/amz-bestsellers-la/.github/workflows/main.yml) to:

- run `bruin format --check`
- execute `bruin dry-run`
- check Terraform formatting with `terraform fmt -check -recursive`
