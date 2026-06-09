# Projeto Final: Engenharia Reversa, Normalização e Análise da Copa do Mundo

Este repositório contém o projeto final desenvolvido para a disciplina de **Banco de Dados 1**, do curso de Sistemas de Informação da Universidade Federal de Alagoas (UFAL).

* **Aluno:** José Humberto Carozo dos Santos  
* **Professora:** Profª Dra. Marianne Diniz  

---

## 1. Sobre o Projeto e Base de Dados
O objetivo deste trabalho foi reestruturar e otimizar um banco de dados relacional a partir do dataset público **FIFA World Cup** (disponível no Kaggle). A partir dos dados brutos, foi feito um processo de modelagem, limpeza e carga de dados, seguido pelo desenvolvimento de 15 consultas SQL para extração de estatísticas e análises históricas sobre o torneio.

---

## 2. Modelagem e Normalização (3FN)

### O Problema dos Dados Brutos (Antes)
Os arquivos CSV originais (`Matches`, `Players` e `Cups`) apresentavam sérios problemas de redundância. Nomes de países, estádios, técnicos e cidades apareciam repetidos textualmente em milhares de linhas, sem chaves primárias ou estrangeiras definidas. Isso gerava desperdício de armazenamento e alto risco de inconsistência nos dados.

### A Estrutura Otimizada (Depois)
Para resolver a duplicidade e aplicar a **Primeira, Segunda e Terceira Formas Normais**, o banco de dados foi dividido no SQLite em 7 tabelas lógicas:

1. **`TB_CIDADE`** (`nome_cidade` como Chave Primária)
2. **`TB_ESTADIO`** (`nome_estadio` PK, `nome_cidade` como Chave Estrangeira)
3. **`TB_SELECAO`** (`sigla` PK, `nome_selecao`)
4. **`TB_COPA`** (`ano` PK)
5. **`TB_TECNICO`** (`nome_tecnico` PK)
6. **`TB_PARTIDA`** (`id_partida` PK, com FKs vinculando o ano da copa, estádio e as siglas das seleções mandante/visitante)
7. **`TB_PARTIDA_JOGADOR`** (Tabela associativa para relacionar os jogadores escalados, número da camisa, posição, titularidade, técnico e a partida correspondente)

---

## 3. Consultas Analíticas (Perguntas de Negócio)
As 15 consultas abaixo foram criadas para explorar o banco de dados de forma não óbvia, utilizando recursos como `INNER JOIN`, `LEFT OUTER JOIN`, funções de agregação (`SUM`, `AVG`, `COUNT`), `GROUP BY`, `HAVING` e ordenações explícitas.

| ID | Pergunta de Negócio / Análise | Contexto e Diferencial da Consulta |
|:---|:---|:---|
| **01** | Média de gols em fases decisivas por estádio. | Cruza o peso das partidas de finais e semifinais com a localização do estádio. |
| **02** | Cidades que receberam a maior variedade de seleções distintas. | Usa `LEFT JOIN` para medir o alcance cultural e fluxo de turismo gerado pelas cidades-sede. |
| **03** | Grandes goleadas dos mandantes associadas ao público presente. | Filtra partidas onde o time da casa fez 4 ou mais gols, ordenando pela média de público. |
| **04** | Técnicos que comandaram mais seleções em Copas diferentes. | Foca no histórico de carreira de treinadores que trabalharam em culturas diferentes. |
| **05** | Uso de jogadores reservas pelas seleções que foram campeãs. | Avalia a rotação do elenco e a importância do banco de reservas na conquista do título. |
| **06** | O peso do "fator casa" para as seleções que sediaram a Copa. | Soma os gols e o público dos países que jogaram o torneio em seu próprio território. |
| **07** | Estádios com menores médias de gols para os times mandantes. | Identifica as arenas onde os times principais tiveram maior dificuldade ofensiva. |
| **08** | Evolução de gols e público divididos por eras do futebol. | Usa a estrutura `CASE` para agrupar o histórico em períodos (Pioneiro, Clássico, Moderno). |
| **09** | Substitutos acionados em jogos que foram para a prorrogação. | Mapeia o desgaste tático em partidas tensas que passaram dos 90 minutos regulamentares. |
| **10** | Partidas com maior presença de camisas 10 em campo. | Analisa confrontos com grande concentração de meio-campistas e armadores clássicos. |
| **11** | Gols sofridos por goleiros que jogaram acumulando a função de capitão. | Cruzamento focado na posição `GKC` (Goleiro/Capitão) para avaliar desempenho defensivo. |
| **12** | Cidades onde os visitantes aplicaram as maiores goleadas. | Mostra o ponto de vista do torcedor local que viu o time da casa sofrer derrotas elásticas. |
| **13** | Copas com alto índice de gols, mas público baixo nas oitavas de final. | Cruza dados macros do torneio com a oscilação de bilheteria no início do mata-mata. |
| **14** | Times invictos jogando em casa com estádios lotados (+50 mil pessoas). | Identifica quais seleções suportaram melhor a pressão de grandes plateias sem perder o saldo. |
| **15** | Média de público nos jogos de técnicos que acumulam mais de 10 partidas. | Avalia se a presença de treinadores históricos no banco influenciou na bilheteria. |

---

## 4. Vídeo de Demonstração
O vídeo abaixo possui duração máxima de 1 minuto e demonstra a estrutura do banco rodando no SGBD, além da execução da consulta baseada em eras históricas (Consulta 08).

👉 **[Link para o vídeo de demonstração]**

---

## 5. Estrutura do Repositório
* 📁 `certificados/` -> Prints que comprovam a conclusão dos módulos de SQL exigidos.
* 📄 `01_modelagem_e_etl.sql` -> Script com a criação das tabelas (DDL) e inserção dos dados normalizados (DML).
* 📄 `02_consultas_analiticas.sql` -> Arquivo com as 15 consultas criadas.
* 🗄️ `PortifolioCopa.db` -> Arquivo final da base de dados SQLite.
* 📖 `README.md` -> Documentação do projeto.

---

## 6. Como Rodar o Projeto
1. Baixe o software gratuito [DB Browser for SQLite](https://sqlitebrowser.org/).
2. Abra o programa e clique em "Abrir base de dados", selecionando o arquivo `PortifolioCopa.db`.
3. Para testar as análises, copie qualquer query contida no arquivo `02_consultas_analiticas.sql` e execute-a na aba "Executar SQL".
