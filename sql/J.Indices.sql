-- ANEXO J. ÍNDICES

USE MapaDeMemorias;

-- ÍNDICES EM EXPERIENCIA
-- Índice composto para pesquisas por autor e estado
-- Beneficia RM01 e RM10
CREATE INDEX idx_experiencia_autor_estado
ON EXPERIENCIA(id_autor, estado);

-- Índice composto para pesquisas por destino e estado
-- Beneficia RM02 e RM09
CREATE INDEX idx_experiencia_destino_estado
ON EXPERIENCIA(id_destino, estado);

-- Índice composto para pesquisas temporais
-- Beneficia RM03
CREATE INDEX idx_experiencia_datas
ON EXPERIENCIA(data_inicio, data_fim);

-- Índice composto para pesquisas por tipo
-- Beneficia RM04
CREATE INDEX idx_experiencia_tipo_estado
ON EXPERIENCIA(tipo_experiencia, estado);

-- ÍNDICES EM DESTINO
-- Índice composto para pesquisas geográficas
-- Beneficia RM02
CREATE INDEX idx_destino_localizacao
ON DESTINO(pais, regiao, cidade);

-- ÍNDICES EM AVALIACAO
-- Índice para junções e agregações de avaliações
-- Beneficia RM05 e RM08
CREATE INDEX idx_avaliacao_experiencia
ON AVALIACAO(id_experiencia, classificacao);

-- ÍNDICES EM MULTIMEDIA
-- Índice para listar multimédia de uma experiência
-- Beneficia RM06
CREATE INDEX idx_multimedia_experiencia
ON MULTIMEDIA(id_experiencia, data_upload);

-- ÍNDICES EM COMENTARIO
-- Índice para listar comentários de uma experiência
-- Beneficia RM07
CREATE INDEX idx_comentario_experiencia
ON COMENTARIO(id_experiencia, data_comentario);

-- ÍNDICES EM UTILIZADOR
-- Nota: email já possui índice UNIQUE (RC1)
-- Índice para filtros de estado em junções
CREATE INDEX idx_utilizador_estado
ON UTILIZADOR(estado_conta);