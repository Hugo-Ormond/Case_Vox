# Case Técnico – Pipeline de Dados  
**Hugo Ormond Vianna Sá Nogueira**  
📞 (21) 99439-4288  
📧 hugo.vianog@gmail.com  

---

## 📁 Organização do Projeto

Optei por organizar o projeto em **pastas separadas para cada etapa**, pois considerei essa abordagem mais clara e estruturada para navegar entre os arquivos e compreender o desenvolvimento por fases.  
Cada pasta contém um **README específico** explicando detalhadamente o que foi feito naquela etapa, as ferramentas utilizadas, as decisões técnicas tomadas e os arquivos disponibilizados.

---

## 🧩 Etapa 1 – Ingestão de Dados

Foi realizada a ingestão dos dados a partir de um container PostgreSQL fornecido. Após análise dos relacionamentos entre tabelas, criei um banco de destino (`landing_zone`) e usei a estratégia de **Foreign Data Wrapper (FDW)** para integrar os dados. Além disso, implementei uma solução de **CDC (Change Data Capture)** para manter as tabelas atualizadas com alterações incrementais. Uma simulação de DAG no Airflow foi incluída como exemplo de orquestração.

---

## ⚙️ Etapa 2 – Transformações com DBT

Com o banco `landing_zone` estruturado, iniciei o uso do **DBT** para criar modelos de transformação. As views geradas seguem boas práticas de modelagem analítica e estão prontas para consumo por ferramentas de visualização. O DBT permitiu versionar, documentar e tornar reprodutível o processo de transformação de dados.

---

## 📊 Etapa 3 – SQL Analítico

Com base nas tabelas e views transformadas, elaborei consultas SQL para responder perguntas de negócio. Essa etapa teve como objetivo demonstrar a capacidade analítica sobre os dados tratados, com foco em insights relevantes para a operação e o cliente.

---

## 📈 Etapa 4 – Visualização e Storytelling

Utilizei o **Tableau Desktop** para criar um painel interativo, consumindo as views criadas com o DBT. O painel oferece uma visão executiva e operacional dos dados, com gráficos e filtros que permitem exploração dinâmica. Também estão disponíveis o arquivo `.hyper`, o workbook `.twb` e uma versão PDF com print do painel.

---
