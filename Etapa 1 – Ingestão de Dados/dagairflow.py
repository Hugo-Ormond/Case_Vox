from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.hooks.postgres_hook import PostgresHook
from datetime import datetime, timedelta

# Função para executar a função CDC no banco de dados PostgreSQL
def execute_cdc_function(func_name):
    # Usando o PostgresHook para conectar ao banco de dados
    hook = PostgresHook(postgres_conn_id='postgres_default')  # 'postgres_default' é o ID da conexão do Airflow
    conn = hook.get_conn()
    cursor = conn.cursor()

    # Executa a função CDC no PostgreSQL
    cursor.execute(f"SELECT {func_name}();")
    cursor.close()
    conn.commit()

# Definição da DAG
dag = DAG(
    'cdc_dag',
    default_args={
        'owner': 'airflow',
        'retries': 1,
        'retry_delay': timedelta(minutes=5),
    },
    description='DAG para capturar alterações com CDC nas tabelas customer e rental',
    schedule_interval=timedelta(hours=1),  # A cada 1 hora
    start_date=datetime(2025, 5, 11),  # Data de início
    catchup=False,
)

# Task para executar a função de captura de mudanças da tabela 'customer'
capture_customer_changes_task = PythonOperator(
    task_id='capture_customer_changes',
    python_callable=execute_cdc_function,
    op_args=['capture_customer_changes'],  # Nome da função CDC a ser executada
    dag=dag,
)

# Task para executar a função de captura de mudanças da tabela 'rental'
capture_rental_changes_task = PythonOperator(
    task_id='capture_rental_changes',
    python_callable=execute_cdc_function,
    op_args=['capture_rental_changes'],  # Nome da função CDC a ser executada
    dag=dag,
)

# Definindo a ordem de execução das tasks
capture_customer_changes_task >> capture_rental_changes_task
