"""
Airflow DAG for the Snowflake and dbt ELT Pipeline.

Workflow:
    dbt deps → dbt run → dbt test
"""

from datetime import datetime

from airflow.sdk import DAG
from airflow.providers.standard.operators.bash import BashOperator


with DAG(
    dag_id="snowflake_dbt_pipeline",
    description="Run dbt transformations and data quality tests",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False,
    tags=["snowflake", "dbt", "elt"],
) as dag:

    dbt_deps = BashOperator(
        task_id="dbt_deps",
        bash_command="cd /opt/dbt/snowflake_data_project && dbt deps",
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="cd /opt/dbt/snowflake_data_project && dbt run",
    )

    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="cd /opt/dbt/snowflake_data_project && dbt test",
    )

    dbt_deps >> dbt_run >> dbt_test
