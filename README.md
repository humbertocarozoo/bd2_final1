# Portfólio SQL: Engenharia Reversa, Normalização e Análise Histórica da Copa do Mundo

**Autor:** José Humberto Carozo dos Santos  
**Curso:** Sistemas de Informação (Universidade Federal de Alagoas)  

---

## 1. O Projeto e a Base de Dados
Este projeto consiste na restruturação completa e na extração de inteligência analítica a partir da base de dados pública **FIFA World Cup** (disponível no [Kaggle](https://www.kaggle.com/datasets/abecklas/fifa-world-cup)). O objetivo principal foi aplicar conceitos avançados de modelação de bases de dados (Engenharia Reversa) e desenvolver queries complexas de negócio para descobrir padrões históricos não óbvios sobre o torneio.

---

## 2. Modelo Entidade-Relacionamento: O Desafio da Normalização

### O "Antes" (Dados Brutos)
Os ficheiros de origem consistiam em 3 documentos CSV (`Matches`, `Players`, `Cups`) que violavam frontalmente a 1ª Forma Normal. Havia redundância massiva: nomes de cidades, estádios, seleções e técnicos repetiam-se em texto livre ao longo de milhares de linhas, sem chaves primárias definidas, propiciando anomalias de atualização e inconsistência de dados.

### O "Depois" (3ª Forma Normal Aplicada)
A estrutura foi completamente redesenhada no SQLite, separando as entidades lógicas para garantir a integridade referencial. O novo esquema relacional otimizado conta com 7 tabelas distintas:

1. **`TB_CIDADE`** (`nome_cidade` PK)
2. **`TB_ESTADIO`** (`nome_estadio` PK, `nome_cidade` FK)
3. **`TB_SELECAO`** (`sigla` PK, `nome_selecao`)
4. **`TB_COPA`** (`ano` PK)
5. **`TB_TECNICO`** (`nome_tecnico` PK)
6. **`TB_PARTIDA`** (`id_partida` PK, com FKs para Copa, Estádio e Seleções)
7. **`TB_PARTIDA_JOGADOR`** (Tabela associativa interligando Jogador, Seleção, Técnico e Partida).

---

## 3. Dossiê das Consultas Analíticas
Para testar a robustez do novo modelo, foram criadas 15 perguntas de negócio com foco em **inovação analítica**. Todas as queries (disponíveis no ficheiro `02_consultas_analiticas.sql`) utilizam junções (`INNER JOIN` / `LEFT OUTER JOIN`), funções de agregação, agrupamentos (`GROUP BY`), e filtragens agregadas (`HAVING`).

| ID | Pergunta de Negócio | Justificativa de Inovação |
|:---|:---|:---|
| **01** | **A Pressão das Finais:** Quais estádios têm a maior média de golos apenas em partidas decisivas? | Vai além do total de golos, cruzando o peso psicológico de uma final/meia-final com a localização geográfica. |
| **02** | **Cidades Cosmopolitas:** Que cidades receberam a maior diversidade de seleções diferentes? | Usa `LEFT OUTER JOIN` para mapear o impacto cultural e o fluxo turístico local no mundo real. |
| **03** | **"Massacres" em Casa:** Maior goleada do mandante cruzada com o delírio do público. | Avalia o impacto do apoio das bancadas em jogos com resultados esmagadores a favor da equipa da casa. |
| **04** | **Técnicos Nómadas:** Que técnicos comandaram mais seleções em anos diferentes? | Foca na carreira executiva, identificando profissionais com capacidade de adaptação a diferentes culturas futebolísticas. |
| **05** | **Importância do Banco:** Campeões que mais usaram reservas. | Análise de gestão desportiva: comprova se o título foi ganho devido à rotação tática do plantel em vez de usar apenas os titulares. |
| **06** | **A Vantagem de Casa:** Seleções mais letais ao jogar no seu próprio país. | Mensura em números (soma de golos e público) o impacto emocional/vantagem de jogar no país sede. |
| **07** | **Estádios "Amaldiçoados":** Palcos com a pior média de golos para os mandantes. | Identifica anomalias históricas onde o apoio local (público) não se traduziu em vitórias desportivas. |
| **08** | **Evolução Ofensiva:** O comportamento tático ao longo das décadas. | Utiliza a função condicional avançada `CASE` para criar partições dinâmicas por época (Pioneiros, Clássico, Moderno). |
| **09** | **Heróis do Banco:** Substitutos acionados em jogos de prorrogação. | Mapeia o desespero tático: momentos em que os treinadores esgotaram as substituições sob pressão para evitar penáltis. |
| **10** | **Encontro das Camisas 10:** Maior concentração de "playmakers" num único jogo. | Um mergulho na mística do futebol, identificando confrontos históricos focados nos talentos organizadores do meio-campo. |
| **11** | **Maldição Guarda-Redes/Capitão:** Guarda-redes capitães que mais sofreram golos. | Cruzamento puramente tático e de liderança (`GKC`), avaliando se a dupla função sobrecarrega o desempenho defensivo. |
| **12** | **Desespero Local:** Maiores goleadas impostas pelos visitantes. | Análise focada na perspetiva do espectador: cidades que pagaram bilhete para ver os visitantes esmagarem a equipa local. |
| **13** | **Fogo de Palha:** Copas com muitos golos, mas baixo público nos oitavos-de-final. | Compara o desempenho do torneio num nível macro com o súbito desinteresse do público na primeira fase a eliminar. |
| **14** | **Fortalezas Intransponíveis:** Invictos em casa diante de megalópoles (+50k pessoas). | Lista seleções que possuem o maior controlo sob alta pressão, sem registo de saldos negativos em grandes plateias. |
| **15** | **Poder dos Técnicos:** A capacidade de atração de público por treinador. | Revela se a "marca" de técnicos consagrados por si só sustenta médias altas de assistência nas bancadas. |

---

## 4. Vídeo de Demonstração (Pitch)
Breve apresentação (1 minuto) demonstrando a estrutura do modelo relacional a funcionar num SGBD, com ênfase na execução e explicação da consulta mais complexa (Evolução Ofensiva nas Décadas via `CASE` e agrupamentos dinâmicos).

🎥 **[INSERIR AQUI O LINK DO SEU VÍDEO DO YOUTUBE/DRIVE]**

---

## 5. Certificações de Nivelamento
A comprovação de proficiência em manipulação de dados e SQL encontra-se na pasta raiz deste repositório.
* 📁 `certificados/` -> *Ver os ficheiros em anexo neste repositório referentes aos cursos do DataCamp.*

---

## 6. Como Executar este Projeto
1. Faça o clone ou o download deste repositório.
2. Pode abrir diretamente o ficheiro `PortifolioCopa.db` no software [DB Browser for SQLite](https://sqlitebrowser.org/) para explorar a base de dados já normalizada e populada.
3. Para rever o processo de Engenharia de Dados (ETL) e Criação de Tabelas, consulte o ficheiro `01_modelagem_e_etl.sql`.
4. As perguntas de negócio encontram-se documentadas e prontas a executar no ficheiro `02_consultas_analiticas.sql`.
