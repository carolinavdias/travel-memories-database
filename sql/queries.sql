-- DEMONSTRAÇÃO - Queries dos RMs com valores concretos
-- (Baseado no Anexo E, com parâmetros substituídos para os dados de teste)

USE MapaDeMemorias;

-- RM01 - Listar todas as experiências de um utilizador
-- (utilizador 1 = João Silva)
SELECT
    E.id_experiencia, E.titulo, E.descricao,
    E.data_inicio, E.data_fim, E.tipo_experiencia,
    D.pais, D.regiao, D.cidade
FROM EXPERIENCIA AS E
INNER JOIN DESTINO AS D ON E.id_destino = D.id_destino
WHERE E.id_autor = 1
    AND E.estado = 'ativa'
ORDER BY E.data_inicio DESC;


-- RM02 - Pesquisar experiências por localização
-- (país = Portugal)
SELECT
    E.id_experiencia, E.titulo, E.descricao,
    E.data_inicio, E.data_fim, E.tipo_experiencia,
    U.nome AS autor_nome,
    D.pais, D.regiao, D.cidade
FROM EXPERIENCIA AS E
INNER JOIN DESTINO AS D ON E.id_destino = D.id_destino
INNER JOIN UTILIZADOR AS U ON E.id_autor = U.id_utilizador
WHERE D.pais = 'Portugal'
    AND E.estado = 'ativa'
    AND U.estado_conta = 'ativo'
ORDER BY E.data_inicio DESC;


-- RM03- Pesquisar experiências por período temporal
-- (entre junho e agosto de 2024)
SELECT
    E.id_experiencia, E.titulo, E.descricao,
    E.data_inicio, E.data_fim, E.tipo_experiencia,
    U.nome AS autor_nome,
    D.pais, D.cidade
FROM EXPERIENCIA AS E
INNER JOIN UTILIZADOR AS U ON E.id_autor = U.id_utilizador
INNER JOIN DESTINO AS D ON E.id_destino = D.id_destino
WHERE E.data_inicio BETWEEN '2024-06-01' AND '2024-08-31'
    AND E.estado = 'ativa'
    AND U.estado_conta = 'ativo'
ORDER BY E.data_inicio DESC;


-- RM04 - Pesquisar experiências por tipo
-- (tipo = cultural)
SELECT
    E.id_experiencia, E.titulo, E.descricao,
    E.data_inicio, E.data_fim, E.tipo_experiencia,
    U.id_utilizador, U.nome AS autor_nome,
    D.pais, D.regiao, D.cidade
FROM EXPERIENCIA AS E
INNER JOIN UTILIZADOR AS U ON E.id_autor = U.id_utilizador
INNER JOIN DESTINO AS D ON E.id_destino = D.id_destino
WHERE E.tipo_experiencia = 'cultural'
    AND E.estado = 'ativa'
    AND U.estado_conta = 'ativo'
ORDER BY E.data_inicio DESC;


-- RM05 - Obter experiências ordenadas por avaliação média
SELECT
    E.id_experiencia, E.titulo, E.descricao,
    E.tipo_experiencia, U.nome AS autor_nome,
    D.pais, D.cidade,
    COALESCE(AVG(AV.classificacao), 0) AS avaliacao_media,
    COUNT(AV.id_avaliacao) AS num_avaliacoes
FROM EXPERIENCIA AS E
INNER JOIN UTILIZADOR AS U ON E.id_autor = U.id_utilizador
INNER JOIN DESTINO AS D ON E.id_destino = D.id_destino
LEFT OUTER JOIN AVALIACAO AS AV ON E.id_experiencia = AV.id_experiencia
WHERE E.estado = 'ativa' AND U.estado_conta = 'ativo'
GROUP BY E.id_experiencia, E.titulo, E.descricao,
         E.tipo_experiencia, U.nome, D.pais, D.cidade
ORDER BY avaliacao_media DESC, num_avaliacoes DESC;


-- RM06 - Listar conteúdos multimédia de uma experiência
-- (experiência 1 = Verão em Lisboa)
SELECT
    M.id_multimedia, M.tipo_ficheiro,
    M.caminho_armazenamento, M.descricao,
    M.data_captura, M.resolucao, M.tamanho_ficheiro,
    M.data_upload, U.nome AS uploader_nome
FROM MULTIMEDIA AS M
INNER JOIN EXPERIENCIA AS E ON M.id_experiencia = E.id_experiencia
INNER JOIN UTILIZADOR AS U ON M.id_utilizador = U.id_utilizador
WHERE M.id_experiencia = 1
    AND E.estado = 'ativa'
ORDER BY M.tipo_ficheiro, M.data_upload DESC;


-- RM07 - Obter todos os comentários de uma experiência
-- (experiência 1 = Verão em Lisboa)
SELECT
    C.id_comentario, C.texto, C.data_comentario,
    U.id_utilizador, U.nome AS autor_comentario,
    E.titulo AS experiencia_titulo
FROM COMENTARIO AS C
INNER JOIN UTILIZADOR AS U ON C.id_utilizador = U.id_utilizador
INNER JOIN EXPERIENCIA AS E ON C.id_experiencia = E.id_experiencia
WHERE C.id_experiencia = 1
    AND E.estado = 'ativa'
    AND U.estado_conta = 'ativo'
ORDER BY C.data_comentario DESC;


-- RM08 - Calcular avaliação média de uma experiência
-- (experiência 1 = Verão em Lisboa)
SELECT
    E.id_experiencia, E.titulo,
    COALESCE(AVG(AV.classificacao), 0) AS avaliacao_media,
    COUNT(AV.id_avaliacao) AS num_avaliacoes
FROM EXPERIENCIA AS E
LEFT OUTER JOIN AVALIACAO AS AV ON E.id_experiencia = AV.id_experiencia
WHERE E.id_experiencia = 1
    AND E.estado = 'ativa'
GROUP BY E.id_experiencia, E.titulo;

-- Alternativa usando função:
SELECT fn_media_avaliacao_experiencia(1) AS avaliacao_media;


-- RM09- Identificar destinos mais populares
SELECT
    D.id_destino, D.pais, D.regiao, D.cidade,
    COUNT(E.id_experiencia) AS num_experiencias
FROM DESTINO AS D
INNER JOIN EXPERIENCIA AS E ON D.id_destino = E.id_destino
WHERE E.estado = 'ativa'
GROUP BY D.id_destino, D.pais, D.regiao, D.cidade
ORDER BY num_experiencias DESC
LIMIT 10;


-- RM10 - Listar utilizadores mais ativos
SELECT
    U.id_utilizador, U.nome, U.email, U.pais_origem,
    COUNT(E.id_experiencia) AS num_experiencias
FROM UTILIZADOR AS U
INNER JOIN EXPERIENCIA AS E ON U.id_utilizador = E.id_autor
WHERE U.estado_conta = 'ativo' AND E.estado = 'ativa'
GROUP BY U.id_utilizador, U.nome, U.email, U.pais_origem
ORDER BY num_experiencias DESC
LIMIT 10;