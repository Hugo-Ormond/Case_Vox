# Etapa 4: Visualização e Storytelling

## Descrição

Nesta etapa, criei uma visualização interativa para o projeto, utilizando a ferramenta **Tableau**. A escolha do Tableau se deu principalmente pelo fato de já ter a ferramenta instalada na minha máquina e, também, porque minha conta no **Qlik Sense** era recente, o que me impedia de criar novos objetos devido às permissões limitadas.

A conexão entre o Tableau e o banco de dados PostgreSQL foi realizada via **JDBC**, permitindo que as views criadas na etapa de modelagem do DBT (Data Build Tool) fossem carregadas diretamente no Tableau para análise visual.

## Arquivos Disponíveis

- **case_vox.hyper**: Arquivo de dados extraído no formato Hyper, que contém as views utilizadas para a construção do painel.
- **caso_vox.twb**: Arquivo do Tableau Workbook, que contém o painel interativo e os gráficos criados.
- **case_vox.pdf**: PDF com o print do painel criado no Tableau. Este documento mostra a visualização geral, mas algumas interações dinâmicas e filtros não são capturados no formato estático.

## Observações

- A visualização foi construída com base nas views criadas anteriormente na etapa de modelagem do DBT, garantindo que os dados sejam consistentes com a camada modelada.
- As funcionalidades dinâmicas do Tableau melhoram a experiência do usuário e fornecem insights mais profundos a partir dos dados.
  
### Escolha das Visualizações

Optando por priorizar insights rápidos e impactantes, escolhi os seguintes componentes para o painel:

1. **Big Numbers (parte superior)**:  
   Apresentam informações chave como:
   - **Receita total**
   - **Total de clientes**
   - **Total de aluguéis**  
   Esses números oferecem uma visão clara e objetiva da performance geral do negócio.

2. **Comparativo entre filiais**:  
   Coloquei um gráfico de setores que permite comparar a performance de cada filial, proporcionando uma visão rápida de como cada unidade está se saindo.

3. **Gráfico de Linha (Análise Temporal)**:  
   Um gráfico de linha, com análise mês a mês, que ajuda a entender a sazonalidade do negócio, identificar possíveis anomalias e avaliar o desempenho de forma temporal.

4. **Top 10 Filmes por Quantidade de Aluguéis**:  
   Um gráfico de barras que destaca os 10 filmes mais alugados. Esse gráfico ajuda a identificar quais filmes têm maior potencial, podendo ser foco de estratégias de marketing ou promoções. Também permite avaliar quais filmes estão com baixa performance e podem precisar de mais atenção.

5. **Histograma de Clientes por Faixa de Valor Gasto**:  
   Esse histograma funciona quase como um *cluster* dos clientes, segmentando-os por faixa de valor gasto. Isso pode ser útil para definir estratégias de marketing mais assertivas, entendendo os grupos de clientes mais e menos rentáveis.

6. **Botão de Exibição de Listagem de Clientes**:  
   Acrescentei um botão que permite ao usuário exibir ou ocultar uma listagem de clientes. Nessa lista, são mostrados dados importantes, como:
   - A faixa de gasto do cliente (conforme o histograma comentado)
   - O e-mail do cliente  
   Isso pode ser útil para ações de marketing personalizadas.
