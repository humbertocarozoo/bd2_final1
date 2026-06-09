SELECT E.nome_estadio, C.nome_cidade, AVG(P.gols_mandante + P.gols_visitante) AS media_gols, COUNT(P.id_partida) AS total_partidas
FROM TB_PARTIDA P
INNER JOIN TB_ESTADIO E ON P.nome_estadio = E.nome_estadio
INNER JOIN TB_CIDADE C ON E.nome_cidade = C.nome_cidade
WHERE P.fase IN ('Final', 'Semi-finals')
GROUP BY E.nome_estadio, C.nome_cidade
HAVING total_partidas >= 1
ORDER BY media_gols DESC
LIMIT 5;

SELECT C.nome_cidade, COUNT(DISTINCT S.sigla) AS total_selecoes_diferentes
FROM TB_CIDADE C
LEFT OUTER JOIN TB_ESTADIO E ON C.nome_cidade = E.nome_cidade
LEFT OUTER JOIN TB_PARTIDA P ON E.nome_estadio = P.nome_estadio
LEFT OUTER JOIN TB_SELECAO S ON P.sigla_mandante = S.sigla OR P.sigla_visitante = S.sigla
GROUP BY C.nome_cidade
HAVING total_selecoes_diferentes > 10
ORDER BY total_selecoes_diferentes DESC
LIMIT 5;

SELECT P.ano, C.pais_sede, AVG(P.publico) AS media_publico, MAX(P.gols_mandante) AS maior_goleada_mandante
FROM TB_PARTIDA P
INNER JOIN TB_COPA C ON P.ano = C.ano
WHERE P.gols_mandante >= 4
GROUP BY P.ano, C.pais_sede
HAVING media_publico > 30000
ORDER BY media_publico DESC;

SELECT PJ.nome_tecnico, COUNT(DISTINCT PJ.sigla_selecao) AS selecoes_diferentes, COUNT(DISTINCT P.ano) AS copas_diferentes
FROM TB_PARTIDA_JOGADOR PJ
INNER JOIN TB_PARTIDA P ON PJ.id_partida = P.id_partida
WHERE PJ.nome_tecnico NOT LIKE '%(N/A)%' AND PJ.nome_tecnico IS NOT NULL
GROUP BY PJ.nome_tecnico
HAVING selecoes_diferentes >= 2 AND copas_diferentes >= 2
ORDER BY selecoes_diferentes DESC, copas_diferentes DESC
LIMIT 5;

SELECT C.campeao, C.ano, COUNT(PJ.nome_jogador) as total_jogadores_reservas_utilizados
FROM TB_COPA C
INNER JOIN TB_SELECAO S ON C.campeao = S.nome_selecao
INNER JOIN TB_PARTIDA P ON P.ano = C.ano AND (P.sigla_mandante = S.sigla OR P.sigla_visitante = S.sigla)
INNER JOIN TB_PARTIDA_JOGADOR PJ ON P.id_partida = PJ.id_partida AND PJ.sigla_selecao = S.sigla
WHERE PJ.titular = 'N'
GROUP BY C.campeao, C.ano
HAVING total_jogadores_reservas_utilizados > 5
ORDER BY total_jogadores_reservas_utilizados DESC;

SELECT C.pais_sede, SUM(P.gols_mandante) AS gols_em_casa, SUM(P.publico) AS publico_total
FROM TB_COPA C
INNER JOIN TB_SELECAO S ON C.pais_sede = S.nome_selecao
INNER JOIN TB_PARTIDA P ON P.ano = C.ano AND P.sigla_mandante = S.sigla
GROUP BY C.pais_sede
HAVING gols_em_casa > 5
ORDER BY gols_em_casa DESC
LIMIT 5;

SELECT E.nome_estadio, C.nome_cidade, AVG(P.gols_mandante) as media_gols_mandante, COUNT(P.id_partida) as total_jogos
FROM TB_ESTADIO E
INNER JOIN TB_PARTIDA P ON E.nome_estadio = P.nome_estadio
LEFT OUTER JOIN TB_CIDADE C ON E.nome_cidade = C.nome_cidade
GROUP BY E.nome_estadio, C.nome_cidade
HAVING total_jogos >= 5
ORDER BY media_gols_mandante ASC
LIMIT 5;

SELECT 
    CASE 
        WHEN P.ano BETWEEN 1930 AND 1950 THEN 'Pioneiros (1930-1950)'
        WHEN P.ano BETWEEN 1954 AND 1978 THEN 'Clássico (1954-1978)'
        WHEN P.ano BETWEEN 1982 AND 2002 THEN 'Moderno (1982-2002)'
        ELSE 'Contemporâneo (2006-2014)'
    END AS periodo,
    SUM(P.gols_mandante + P.gols_visitante) AS total_gols,
    AVG(P.publico) AS media_publico
FROM TB_PARTIDA P
GROUP BY periodo
HAVING total_gols > 100
ORDER BY media_publico DESC;

SELECT P.fase, P.condicao_vitoria, COUNT(PJ.nome_jogador) AS reservas_acionados
FROM TB_PARTIDA P
INNER JOIN TB_PARTIDA_JOGADOR PJ ON P.id_partida = PJ.id_partida
WHERE P.condicao_vitoria IS NOT NULL AND P.condicao_vitoria != ' ' AND PJ.titular = 'N'
GROUP BY P.fase, P.condicao_vitoria
HAVING reservas_acionados >= 3
ORDER BY reservas_acionados DESC
LIMIT 5;

SELECT P.data_hora, P.nome_estadio, P.sigla_mandante, P.sigla_visitante, COUNT(PJ.nome_jogador) AS quantidade_camisas_10
FROM TB_PARTIDA P
INNER JOIN TB_PARTIDA_JOGADOR PJ ON P.id_partida = P.id_partida
WHERE PJ.numero_camisa = 10
GROUP BY P.id_partida, P.data_hora, P.nome_estadio, P.sigla_mandante, P.sigla_visitante
HAVING quantidade_camisas_10 >= 2
ORDER BY P.data_hora ASC
LIMIT 5;

SELECT PJ.nome_jogador AS goleiro_capitao, S.nome_selecao,
    SUM(CASE WHEN P.sigla_mandante = S.sigla THEN P.gols_visitante ELSE P.gols_mandante END) AS gols_sofridos,
    COUNT(P.id_partida) AS total_partidas
FROM TB_PARTIDA_JOGADOR PJ
INNER JOIN TB_SELECAO S ON PJ.sigla_selecao = S.sigla
INNER JOIN TB_PARTIDA P ON PJ.id_partida = P.id_partida
WHERE PJ.posicao = 'GKC'
GROUP BY PJ.nome_jogador, S.nome_selecao
HAVING total_partidas >= 2
ORDER BY gols_sofridos DESC
LIMIT 5;

SELECT C.nome_cidade, COUNT(P.id_partida) AS surras_dos_visitantes, MAX(P.gols_visitante - P.gols_mandante) AS maior_diferenca_gols
FROM TB_CIDADE C
INNER JOIN TB_ESTADIO E ON C.nome_cidade = E.nome_cidade
INNER JOIN TB_PARTIDA P ON E.nome_estadio = P.nome_estadio
WHERE P.gols_visitante - P.gols_mandante >= 3
GROUP BY C.nome_cidade
HAVING surras_dos_visitantes > 0
ORDER BY surras_dos_visitantes DESC, maior_diferenca_gols DESC
LIMIT 5;

SELECT CP.ano, CP.campeao, CP.gols_marcados AS gols_torneio, MIN(P.publico) AS menor_publico_oitavas
FROM TB_COPA CP
LEFT OUTER JOIN TB_PARTIDA P ON CP.ano = P.ano
WHERE P.fase = 'Round of 16'
GROUP BY CP.ano, CP.campeao, CP.gols_marcados
HAVING menor_publico_oitavas < 50000
ORDER BY gols_torneio DESC;

SELECT S.nome_selecao, COUNT(P.id_partida) AS jogos_mandante, SUM(P.gols_mandante) AS gols_feitos, MIN(P.gols_mandante - P.gols_visitante) AS pior_saldo_no_jogo
FROM TB_SELECAO S
INNER JOIN TB_PARTIDA P ON S.sigla = P.sigla_mandante
WHERE P.publico > 50000
GROUP BY S.nome_selecao
HAVING pior_saldo_no_jogo >= 0 AND jogos_mandante > 3
ORDER BY jogos_mandante DESC
LIMIT 5;

SELECT PJ.nome_tecnico, COUNT(P.id_partida) AS jogos_comandados, AVG(P.publico) as capacidade_atracao_publico
FROM TB_PARTIDA_JOGADOR PJ
INNER JOIN TB_PARTIDA P ON PJ.id_partida = P.id_partida
WHERE PJ.titular = 'S' 
GROUP BY PJ.nome_tecnico
HAVING jogos_comandados > 10
ORDER BY capacidade_atracao_publico DESC
LIMIT 5;