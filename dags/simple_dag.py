from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
with DAG(
    'dbt_run_daily',
    default_args=default_args,
    description='Run dbt models daily',
    schedule_interval='0 1 * * *',  # daily at 1 AM
    start_date=datetime(2026, 1, 22),
    catchup=False,
) as dag:

    # Task to run dbt
    run_dbt = BashOperator(
        task_id='run_dbt',
        bash_command='dbt run --profiles-dir /root/.dbt --project-dir /app/dbt_project'
    )
