## Etapa 1 – Ingestão de Dados

Nesta primeira etapa, realizei a ingestão e estruturação inicial dos dados, bem como a preparação para atualizações contínuas através de uma estratégia de CDC (Change Data Capture).

### 1.1 Restauração do Banco de Dados e Análise das Tabelas

Inicialmente, utilizei o seguinte comando para subir o banco disponibilizado pelo case:

```bash
docker run --name db-teste -d -p 5432:5432 voxtecnologiahub/dbinterview:latest
```

Com isso, consegui acessar o banco `dbinterview` via DBeaver, realizar a análise estrutural e consultar os dados disponíveis.

Utilizei o script `analise_relacoes.sql` para extrair as relações entre tabelas por chave primária e estrangeira, o que possibilitou a construção do documento técnico `documento_relacoes_tabelas.pdf` com os principais relacionamentos mapeados.

### 1.2 Criação da Área de Landing Zone

A seguir, criei um novo banco chamado `landing_zone`, no qual replicamos as estruturas de tabelas do banco original com o auxílio do script `criacao_banco_objetos_lz.sql`, obtido a partir dos comandos DDL extraídos no próprio DBeaver.

Para realizar a cópia dos dados entre os bancos PostgreSQL, optei por utilizar o recurso de **Foreign Data Wrapper (FDW)**, que permite realizar consultas entre diferentes bases de dados PostgreSQL como se fossem uma só.

No meu caso, o FDW foi configurado para que o banco `landing_zone` pudesse acessar diretamente as tabelas do banco `dbinterview`. Dessa forma:

- Criamos conexões com o banco remoto (`dbinterview`)
- Importamos as tabelas desejadas como tabelas estrangeiras no `landing_zone`
- Inserimos os dados em tabelas locais consultando as tabelas remotas

Essa abordagem é vantajosa por:

- Evitar replicação desnecessária
- Permitir leitura de dados atualizados em tempo real
- Reduzir a complexidade de ETL
- Ser nativamente suportada pelo PostgreSQL

As extrações via FDW estão descritas no arquivo `fdw_populando_tabelas_lz.sql`.

### 1.3 Estratégia de CDC

Para acompanhar atualizações futuras nas tabelas mais volumosas (`customer` e `rental`), implementei uma estratégia de CDC baseada em funções SQL e uma tabela de controle com timestamp do último processamento.

O funcionamento é:

- Criamos uma tabela `cdc_control` que registra o último `last_update` processado para cada tabela.
- A cada execução, comparamos o `last_update` dos registros da origem com a data registrada e, se forem mais recentes, os dados são inseridos em tabelas de extensão (`customer_ext` e `rental_ext`).
- Após o processamento, a data de controle é atualizada com o último `last_update`.

As funções criadas estão detalhadas no arquivo `cdc_control.sql`.

Optei por essa estratégia por ser simples, eficaz e compatível com a estrutura relacional do PostgreSQL, garantindo controle incremental sem necessidade de ferramentas externas.

### 1.4 Airflow – Tentativa de Orquestração

Busquei automatizar esse processo via Apache Airflow. No entanto, devido a limitações computacionais locais (uso de CPU excessivo ao subir o ambiente via Docker), não foi possível manter o Airflow em funcionamento estável na máquina.

Apesar disso, desenvolvemos um código funcional simulado da DAG, salvo como `dagairflow.py`, que:

- Conecta-se ao banco PostgreSQL via `PostgresHook`
- Executa as funções `capture_customer_changes` e `capture_rental_changes`
- Agenda a execução a cada 1 hora (`schedule_interval=timedelta(hours=1)`)

Essa DAG, se integrada a um ambiente Airflow funcional, seria capaz de agendar automaticamente a captura das alterações e manter a `landing_zone` atualizada de forma contínua.

Peço desculpas por não termos conseguido subir o ambiente completo do Airflow, mas deixo disponível o código com a lógica completa que, provavelmente, seria executada.

### Arquivos Disponíveis

- **analise_relacoes.sql**: Script para identificar os relacionamentos entre tabelas via PK/FK.
- **documento_relacoes_tabelas.pdf**: Documento técnico com os principais relacionamentos identificados.
- **criacao_banco_objetos_lz.sql**: Código SQL para criação do banco e das tabelas no **landing_zone**.
- **fdw_populando_tabelas_lz.sql**: Implementação da estratégia de ingestão via FDW.
- **cdc_control.sql**: Criação das funções de captura de mudanças (CDC) para as tabelas **customer** e **rental**.
- **dagairflow.py**: Exemplo de código Python que simula a DAG do Airflow para agendamento das funções de CDC.

