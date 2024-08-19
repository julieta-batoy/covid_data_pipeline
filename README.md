# COVID-19 Data Pipeline

## Overview
This project sets up a data pipeline for ingesting, processing, storing, and analyzing COVID-19 data from the [CSSEGISandData repository](https://github.com/CSSEGISandData/COVID-19). The pipeline uses Dagster for orchestration, dbt for data processing, and PostgreSQL for data storage.

## Project Structure
- **`dags/covid_data_ingestion.py`**: Contains Dagster jobs and operations for data ingestion
- **`dbt/models/staging/staging_covid_data.sql`**: dbt model for cleaning and transforming data
- **`dbt/models/mart/staging_covid_data.sql`**: dbt model for processed data
- **`dbt/dbt_project.yml`**: Configures the dbt project
- **`dbt/profiles.yml`**: Contains the database connection configuration for the dbt project
- **`scripts/setup_postgres.sql`**: SQL scripts for setting up the PostgreSQL database
- **`sql_queries/analysis_queries.sql`**: SQL queries for data analysis
- **`.env`**: Stores environment variables
- **`.gitignore`**: Specifies files and directories that should be ignored by Git
- **`README.md`**: Provides a comprehensive guide to the COVID-19 Data Pipeline project
- **`requirements.txt`**: Lists the Python dependencies required by data pipeline

## Setup Instructions
1. Clone the repository:
    - Download: https://github.com/julieta-batoy/covid_data_pipeline/archive/refs/heads/main.zip

2. Create a Python virtual environment and install dependencies:
    ```python
    python -m venv venv
    venv/bin/activate
    pip install -r requirements.txt

3. Set up the PostgreSQL database:
    ```bash
    psql -h localhost -U postgres -f scripts/setup_postgres.sql

4. Modify the `.env` based on the setup no. 3 (Set up the PostgreSQL database):
    ```bash
    # "postgresql://" database type and protocol
    # "user:" username required to authenticate with the PostgreSQL database
    # "password@" password associated with the user account
    # "localhost" hostname or IP address of the database server
    # ":5432"  port number on which the PostgreSQL server is listening for connections
    # "database_name" name of database
    
    STAGING_DB=postgresql://user:password@localhost:5432/database_name

5. Run the Dagster pipeline to ingest the data:
    ```bash
    dagster job execute -f dags/covid_data_ingestion.py

6. Modify the `dbt/profiles.yml` based on the database configuration:
    ```yaml
        # Example
    
        default:
        target: dev
        outputs:
            dev:
            type: postgres
            host: localhost
            user: user123
            password: pass123
            dbname: staging_covid_db
            schema: public
            threads: 4
            port: 5432
            keepalives_idle: 0
            connect_timeout: 10
            sslmode: prefer
            search_path: public

7. Use dbt to process the data:
    ```bash
    cd dbt
    dbt run

8. Analyze the data using the provided SQL queries in `sql_queries/analysis_queries.sql`.

## Design Decisions
- **Dagster** for orchestration due to its flexibility in managing complex workflows.
- **dbt** for data transformation to ensure modular, reusable, and maintainable SQL.
- **PostgreSQL** as the storage backend for its robust querying capabilities.

## Analysis
1. **Top 5 most common values in a particular column and their frequency.:** See SQL query in `sql_queries/analysis_queries.sql`.
2. **How does a particular metric change over time?:** See SQL query in `sql_queries/analysis_queries.sql`.
3. **Is there a correlation between two specific columns?:** See SQL query in `sql_queries/analysis_queries.sql`.
