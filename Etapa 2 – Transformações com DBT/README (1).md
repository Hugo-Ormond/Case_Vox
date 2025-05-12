# Etapa 2: Modelagem e Transformação - DBT

## Descrição

Nesta etapa, utilzei o **DBT (Data Build Tool)** para criar a camada modelada (Data Warehouse), estruturando os dados em marts derivados para facilitar a análise e visualização.

Foram criados três modelos principais:
- **`mart_customer_lifetime_value`**: Valor total gasto por cliente e tempo desde a primeira locação.
- **`mart_film_popularity`**: Ranking de filmes mais alugados por período (mês/ano).
- **`mart_store_performance`**: Performance de cada loja (quantidade de locações, receita, etc.).

A utilização de **views** ao invés de tabelas físicas é uma boa prática, especialmente em plataformas de visualização de dados, como **Tableau**. As views oferecem vantagens relacionadas a **Desempenho**, **Facilidade de Manutenção** e **Segurança**.

## Passos Realizados

1. **Instalação do DBT**:
   - Para instalar o DBT, utilize o seguinte comando:
     ```bash
     pip install dbt
     ```

2. **Inicialização do Projeto DBT**:
   - Criação do projeto DBT com o comando:
     ```bash
     dbt init meu_projeto_dbt
     ```

3. **Execução do DBT**:
   - Após a criação dos arquivos necessários do DBT (como o `dbt_project.yml`, `profiles.yml` e os arquivos SQL na pasta de modelos), execute o comando:
     ```bash
     dbt run
     ```

   O comando `dbt run` foi utilizado para executar os modelos e gerar as views no banco de dados.

## Arquivos Disponíveis

- **profile.yml**: Arquivo YML com as configurações de conexão do DBT.
- **dbt_project.yml**: Arquivo YML com a configuração do projeto DBT.
- **mart_customer_lifetime_value.sql**: SQL contendo o modelo de valor vitalício do cliente.
- **mart_film_popularity.sql**: SQL contendo o modelo de ranking de popularidade dos filmes por mês/ano.
- **mart_store_performance.sql**: SQL contendo o modelo de performance das lojas (receita, número de locações etc).
- **receita_loja_data.sql**: SQL extra utilizado na etapa 4 para a visualização da receita por loja ao longo do tempo.
- **saidaCMD.jpg**: Imagem com a saída do comando `dbt run` no prompt de comando.
- **views_db.jpg**: Print dos nomes das views criadas no banco **landing_zone**, visualizados pela interface do **DBeaver**.

