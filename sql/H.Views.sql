-- ANEXO H. VIEWS

USE MapaDeMemorias;

-- 1) Ficha pública da experiência (RM05/RM08)
CREATE OR REPLACE VIEW vw_experiencia_publica AS
SELECT
  e.id_experiencia, e.titulo, e.descricao,
  e.data_inicio, e.data_fim, e.tipo_experiencia,
  e.data_criacao, e.estado,
  u.id_utilizador AS id_autor,
  u.nome AS autor_nome,
  d.id_destino, d.pais, d.regiao, d.cidade,
  COALESCE(av.avaliacao_media, 0) AS avaliacao_media,
  COALESCE(av.num_avaliacoes, 0) AS num_avaliacoes,
  COALESCE(cm.num_comentarios, 0) AS num_comentarios,
  COALESCE(mm.num_multimedia, 0) AS num_multimedia
FROM EXPERIENCIA e
JOIN UTILIZADOR u ON u.id_utilizador = e.id_autor
JOIN DESTINO d ON d.id_destino = e.id_destino
LEFT JOIN (
  SELECT id_experiencia,
         AVG(classificacao) AS avaliacao_media,
         COUNT(*) AS num_avaliacoes
  FROM AVALIACAO GROUP BY id_experiencia
) av ON av.id_experiencia = e.id_experiencia
LEFT JOIN (
  SELECT id_experiencia, COUNT(*) AS num_comentarios
  FROM COMENTARIO GROUP BY id_experiencia
) cm ON cm.id_experiencia = e.id_experiencia
LEFT JOIN (
  SELECT id_experiencia, COUNT(*) AS num_multimedia
  FROM MULTIMEDIA GROUP BY id_experiencia
) mm ON mm.id_experiencia = e.id_experiencia
WHERE e.estado = 'ativa' AND u.estado_conta = 'ativo';

-- 2) Experiências por utilizador (RM01)
CREATE OR REPLACE VIEW vw_experiencias_por_utilizador AS
SELECT
  e.id_experiencia, e.id_autor, e.titulo,
  e.data_inicio, e.data_fim, e.tipo_experiencia,
  d.pais, d.regiao, d.cidade
FROM EXPERIENCIA e
JOIN DESTINO d ON d.id_destino = e.id_destino
WHERE e.estado = 'ativa';

-- 3) Multimédia por experiência (RM06)
CREATE OR REPLACE VIEW vw_multimedia_por_experiencia AS
SELECT
  m.id_multimedia, m.id_experiencia,
  e.titulo AS experiencia_titulo,
  m.id_utilizador, u.nome AS uploader_nome,
  m.tipo_ficheiro, m.caminho_armazenamento,
  m.descricao, m.data_captura, m.resolucao,
  m.tamanho_ficheiro, m.data_upload
FROM MULTIMEDIA m
JOIN EXPERIENCIA e ON e.id_experiencia = m.id_experiencia
JOIN UTILIZADOR u ON u.id_utilizador = m.id_utilizador
WHERE e.estado = 'ativa' AND u.estado_conta = 'ativo';

-- 4) Comentários por experiência (RM07)
CREATE OR REPLACE VIEW vw_comentarios_por_experiencia AS
SELECT
  c.id_comentario, c.id_experiencia,
  e.titulo AS experiencia_titulo,
  c.id_utilizador, u.nome AS autor_comentario,
  c.texto, c.data_comentario
FROM COMENTARIO c
JOIN EXPERIENCIA e ON e.id_experiencia = c.id_experiencia
JOIN UTILIZADOR u ON u.id_utilizador = c.id_utilizador
WHERE e.estado = 'ativa' AND u.estado_conta = 'ativo';

-- 5) Destinos mais populares (RM09)
CREATE OR REPLACE VIEW vw_destinos_populares AS
SELECT
  d.id_destino, d.pais, d.regiao, d.cidade,
  COUNT(*) AS num_experiencias
FROM DESTINO d
JOIN EXPERIENCIA e ON e.id_destino = d.id_destino
WHERE e.estado = 'ativa'
GROUP BY d.id_destino, d.pais, d.regiao, d.cidade;

-- 6) Utilizadores mais ativos (RM10)
CREATE OR REPLACE VIEW vw_utilizadores_mais_ativos AS
SELECT
  u.id_utilizador, u.nome, u.email,
  COUNT(*) AS num_experiencias
FROM UTILIZADOR u
JOIN EXPERIENCIA e ON e.id_autor = u.id_utilizador
WHERE u.estado_conta = 'ativo' AND e.estado = 'ativa'
GROUP BY u.id_utilizador, u.nome, u.email;