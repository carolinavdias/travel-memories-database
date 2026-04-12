-- BASE DE DAODS: MAPA DE MEMÓRIAS

DROP DATABASE IF EXISTS MapaDeMemorias;
CREATE DATABASE MapaDeMemorias
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE MapaDeMemorias;

-- ============================================================================
-- TABELAS (Anexo F)
-- ============================================================================

CREATE TABLE UTILIZADOR (
    id_utilizador INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    biografia TEXT,
    fotografia_perfil VARCHAR(80),
    pais_origem VARCHAR(80),
    data_registo DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_conta ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
    PRIMARY KEY(id_utilizador)
) ENGINE = InnoDB;

CREATE TABLE DESTINO (
    id_destino INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(80) NOT NULL,
    regiao VARCHAR(80),
    cidade VARCHAR(120) NOT NULL,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    PRIMARY KEY(id_destino),
    UNIQUE KEY unique_location (pais, regiao, cidade)
) ENGINE = InnoDB;

CREATE TABLE EXPERIENCIA (
    id_experiencia INT NOT NULL AUTO_INCREMENT,
    id_autor INT NOT NULL,
    id_destino INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    tipo_experiencia ENUM('cultural', 'aventura', 'gastronomica', 'natureza', 'urbana') NOT NULL,
    data_criacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('ativa', 'removida') NOT NULL DEFAULT 'ativa',
    PRIMARY KEY(id_experiencia),
    FOREIGN KEY(id_autor) REFERENCES UTILIZADOR(id_utilizador) ON DELETE CASCADE,
    FOREIGN KEY(id_destino) REFERENCES DESTINO(id_destino) ON DELETE RESTRICT,
    CHECK (data_fim IS NULL OR data_fim >= data_inicio)
) ENGINE = InnoDB;

CREATE TABLE MULTIMEDIA (
    id_multimedia INT NOT NULL AUTO_INCREMENT,
    id_experiencia INT NOT NULL,
    id_utilizador INT NOT NULL,
    tipo_ficheiro ENUM('imagem', 'video', 'audio') NOT NULL,
    caminho_armazenamento VARCHAR(50) NOT NULL,
    descricao TEXT,
    data_captura DATETIME,
    resolucao VARCHAR(50),
    tamanho_ficheiro BIGINT,
    data_upload DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_multimedia),
    FOREIGN KEY(id_experiencia) REFERENCES EXPERIENCIA(id_experiencia) ON DELETE CASCADE,
    FOREIGN KEY(id_utilizador) REFERENCES UTILIZADOR(id_utilizador) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE COMENTARIO (
    id_comentario INT NOT NULL AUTO_INCREMENT,
    id_utilizador INT NOT NULL,
    id_experiencia INT NOT NULL,
    texto TEXT NOT NULL,
    data_comentario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_comentario),
    FOREIGN KEY(id_utilizador) REFERENCES UTILIZADOR(id_utilizador) ON DELETE CASCADE,
    FOREIGN KEY(id_experiencia) REFERENCES EXPERIENCIA(id_experiencia) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE AVALIACAO (
    id_avaliacao INT NOT NULL AUTO_INCREMENT,
    id_utilizador INT NOT NULL,
    id_experiencia INT NOT NULL,
    classificacao TINYINT NOT NULL,
    data_avaliacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_avaliacao),
    FOREIGN KEY(id_utilizador) REFERENCES UTILIZADOR(id_utilizador) ON DELETE CASCADE,
    FOREIGN KEY(id_experiencia) REFERENCES EXPERIENCIA(id_experiencia) ON DELETE CASCADE,
    UNIQUE KEY unique_user_experience (id_utilizador, id_experiencia),
    CHECK (classificacao BETWEEN 0 AND 5)
) ENGINE = InnoDB;

-- ============================================================================
-- DADOS (Anexo G)
-- ============================================================================

INSERT INTO UTILIZADOR (nome, email, password, biografia, fotografia_perfil, pais_origem, data_registo, estado_conta) VALUES
('João Silva', 'joao.silva@email.com', '$2y$10$hash123', 'Apaixonado por viagens culturais e história', 'perfil1.jpg', 'Portugal', '2024-01-15 10:30:00', 'ativo'),
('Maria Costa', 'maria.costa@email.com', '$2y$10$hash456', 'Exploradora de novas culturas e sabores', 'perfil2.jpg', 'Brasil', '2024-02-20 14:20:00', 'ativo'),
('Pedro Santos', 'pedro.santos@email.com', '$2y$10$hash789', 'Amante de aventuras nas montanhas', 'perfil3.jpg', 'Portugal', '2024-03-10 09:15:00', 'ativo'),
('Ana Ferreira', 'ana.ferreira@email.com', '$2y$10$hash101', 'Fotógrafa de viagens profissional', 'perfil4.jpg', 'Espanha', '2024-04-05 16:45:00', 'ativo'),
('Carlos Oliveira', 'carlos.oliveira@email.com', '$2y$10$hash112', 'Gastrónomo e crítico de restaurantes', 'perfil5.jpg', 'Portugal', '2024-05-12 11:00:00', 'ativo');

INSERT INTO DESTINO (pais, regiao, cidade, latitude, longitude) VALUES
('Portugal', 'Lisboa', 'Lisboa', 38.722252, -9.139337),
('Portugal', 'Norte', 'Porto', 41.157944, -8.629105),
('Suíça', 'Valais', 'Zermatt', 46.020654, 7.749117),
('França', 'Provença', 'Nice', 43.710173, 7.261953),
('Brasil', 'Rio de Janeiro', 'Rio de Janeiro', -22.906847, -43.172896),
('Portugal', 'Algarve', 'Faro', 37.019356, -7.930439),
('Espanha', 'Catalunha', 'Barcelona', 41.385064, 2.173404);

INSERT INTO EXPERIENCIA (id_autor, id_destino, titulo, descricao, data_inicio, data_fim, tipo_experiencia, data_criacao, estado) VALUES
(1, 1, 'Verão em Lisboa', 'Passeio cultural pela capital portuguesa, visitando museus e monumentos históricos como a Torre de Belém e o Mosteiro dos Jerónimos', '2024-07-01', '2024-07-07', 'cultural', '2024-08-01 10:00:00', 'ativa'),
(1, 2, 'Inverno no Porto', 'Experiência gastronómica no norte de Portugal, incluindo visita às caves do vinho do Porto e degustação de francesinha', '2024-12-20', '2024-12-27', 'gastronomica', '2025-01-10 15:30:00', 'ativa'),
(2, 3, 'Aventura nos Alpes', 'Esqui e montanhismo em Zermatt durante o inverno suíço, com vistas deslumbrantes do Matterhorn', '2025-01-15', '2025-01-22', 'aventura', '2025-02-01 09:00:00', 'ativa'),
(2, 1, 'Primavera em Sintra', 'Descoberta de palácios e natureza exuberante nos arredores de Lisboa, visitando o Palácio da Pena e a Quinta da Regaleira', '2025-04-10', '2025-04-12', 'natureza', '2025-04-15 14:00:00', 'ativa'),
(3, 4, 'Costa Azul francesa', 'Relaxamento na Riviera Francesa com praias paradisíacas e gastronomia mediterrânica refinada', '2024-08-05', '2024-08-15', 'natureza', '2024-09-01 11:30:00', 'ativa'),
(4, 5, 'Carnaval no Rio', 'Imersão na cultura brasileira durante o carnaval carioca, com desfiles no Sambódromo e blocos de rua', '2024-02-10', '2024-02-14', 'cultural', '2024-03-01 16:00:00', 'ativa'),
(1, 6, 'Praias do Algarve', 'Roteiro pelas melhores praias algarvias durante o verão, incluindo Praia da Marinha e Benagil', '2024-06-15', '2024-06-22', 'natureza', '2024-07-01 10:00:00', 'ativa'),
(3, 7, 'Gaudí em Barcelona', 'Visita às obras-primas de Antoni Gaudí na capital catalã, incluindo Sagrada Família e Park Güell', '2024-09-05', '2024-09-08', 'cultural', '2024-09-20 13:00:00', 'ativa'),
(5, 2, 'Francesinha no Porto', 'Tour gastronómico dedicado à francesinha e outros pratos típicos portuenses em restaurantes tradicionais', '2024-11-01', '2024-11-03', 'gastronomica', '2024-11-15 12:00:00', 'ativa'),
(2, 6, 'Verão algarvio', 'Férias de verão completas no Algarve com praia, passeios de barco e exploração de grutas marinhas', '2024-07-20', '2024-07-30', 'natureza', '2024-08-10 09:00:00', 'ativa');

INSERT INTO MULTIMEDIA (id_experiencia, id_utilizador, tipo_ficheiro, caminho_armazenamento, descricao, data_captura, resolucao, tamanho_ficheiro, data_upload) VALUES
(1, 1, 'imagem', '/media/img001.jpg', 'Torre de Belém ao pôr do sol', '2024-07-03 18:30:00', '1920x1080', 2500, '2024-08-01 10:30:00'),
(1, 1, 'imagem', '/media/img002.jpg', 'Pastéis de Belém recém-saídos do forno', '2024-07-04 10:15:00', '1920x1080', 1800, '2024-08-01 10:35:00'),
(1, 1, 'video', '/media/vid001.mp4', 'Tour pelo bairro de Alfama', '2024-07-05 14:00:00', '1920x1080', 85000, '2024-08-01 11:00:00'),
(2, 1, 'imagem', '/media/img003.jpg', 'Caves do Vinho do Porto', '2024-12-22 15:45:00', '1920x1080', 3200, '2025-01-10 15:45:00'),
(3, 2, 'imagem', '/media/img004.jpg', 'Vista do Matterhorn com neve', '2025-01-17 12:30:00', '4000x3000', 4500, '2025-02-01 09:30:00'),
(3, 2, 'video', '/media/vid002.mp4', 'Descida de esqui na pista vermelha', '2025-01-18 10:00:00', '1920x1080', 120000, '2025-02-01 10:00:00'),
(4, 2, 'imagem', '/media/img005.jpg', 'Palácio da Pena em Sintra', '2025-04-11 11:20:00', '1920x1080', 2900, '2025-04-15 14:30:00'),
(6, 4, 'imagem', '/media/img006.jpg', 'Desfile de Carnaval no Sambódromo', '2024-02-12 21:00:00', '1920x1080', 3800, '2024-03-01 16:30:00'),
(1, 3, 'imagem', '/media/img007.jpg', 'Miradouro de Santa Luzia', '2024-07-06 16:45:00', '1920x1080', 2200, '2024-08-05 11:00:00'),
(7, 1, 'video', '/media/vid003.mp4', 'Praia da Marinha ao nascer do sol', '2024-06-17 06:30:00', '3840x2160', 95000, '2024-07-01 10:30:00'),
(8, 3, 'imagem', '/media/img008.jpg', 'Sagrada Família vista exterior', '2024-09-06 14:20:00', '1920x1080', 3100, '2024-09-20 13:30:00'),
(9, 5, 'imagem', '/media/img009.jpg', 'Francesinha tradicional portuense', '2024-11-02 13:15:00', '1920x1080', 2000, '2024-11-15 12:30:00');

INSERT INTO COMENTARIO (id_utilizador, id_experiencia, texto, data_comentario) VALUES
(2, 1, 'Que experiência incrível! Adorei as fotos de Lisboa, principalmente a Torre de Belém ao pôr do sol. Inspirador!', '2024-08-05 14:30:00'),
(3, 1, 'Os pastéis de Belém parecem absolutamente deliciosos! Tenho mesmo de ir a Lisboa experimentar pessoalmente.', '2024-08-06 10:15:00'),
(1, 3, 'Zermatt é fantástico para esquiar! Excelente escolha para quem gosta de montanhismo e desportos de inverno.', '2025-02-03 16:00:00'),
(4, 3, 'As montanhas suíças estão absolutamente lindas nessa altura do ano! A neve parece perfeita para esquiar.', '2025-02-04 09:30:00'),
(1, 6, 'O Carnaval do Rio é mesmo uma experiência única! Quero muito ir um dia viver essa energia incrível.', '2024-03-05 11:00:00'),
(3, 2, 'O vinho do Porto é espetacular! As caves são uma experiência imperdível para quem visita a cidade.', '2025-01-15 15:00:00'),
(5, 1, 'Lisboa tem uma energia única! A cidade é linda e cheia de história por todo o lado.', '2024-08-10 12:00:00'),
(2, 4, 'Sintra é absolutamente mágica! Os palácios parecem saídos de um conto de fadas.', '2025-04-20 14:30:00'),
(4, 8, 'Gaudí é mesmo um génio da arquitetura! A Sagrada Família é absolutamente impressionante.', '2024-09-25 16:00:00'),
(1, 7, 'As praias algarvias são maravilhosas! Água cristalina e falésias deslumbrantes.', '2024-07-05 10:00:00');

INSERT INTO AVALIACAO (id_utilizador, id_experiencia, classificacao, data_avaliacao) VALUES
(2, 1, 5, '2024-08-05 14:35:00'),
(3, 1, 4, '2024-08-06 10:20:00'),
(4, 1, 5, '2024-08-07 11:00:00'),
(1, 3, 5, '2025-02-03 16:05:00'),
(4, 3, 5, '2025-02-04 09:35:00'),
(1, 6, 4, '2024-03-05 11:05:00'),
(2, 6, 5, '2024-03-06 15:00:00'),
(3, 2, 4, '2025-01-15 15:05:00'),
(2, 4, 5, '2025-04-20 14:35:00'),
(1, 5, 4, '2024-09-10 12:00:00'),
(5, 1, 5, '2024-08-10 12:05:00'),
(2, 7, 5, '2024-07-10 16:00:00'),
(4, 8, 5, '2024-09-25 16:05:00'),
(3, 9, 4, '2024-11-20 10:00:00'),
(1, 10, 4, '2024-08-15 11:00:00');

-- ============================================================================
-- VIEWS (Anexo H)
-- ============================================================================

CREATE VIEW vw_experiencia_publica AS
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
  SELECT id_experiencia, AVG(classificacao) AS avaliacao_media, COUNT(*) AS num_avaliacoes
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

CREATE VIEW vw_experiencias_por_utilizador AS
SELECT
  e.id_experiencia, e.id_autor, e.titulo,
  e.data_inicio, e.data_fim, e.tipo_experiencia,
  d.pais, d.regiao, d.cidade
FROM EXPERIENCIA e
JOIN DESTINO d ON d.id_destino = e.id_destino
WHERE e.estado = 'ativa';

CREATE VIEW vw_multimedia_por_experiencia AS
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

CREATE VIEW vw_comentarios_por_experiencia AS
SELECT
  c.id_comentario, c.id_experiencia,
  e.titulo AS experiencia_titulo,
  c.id_utilizador, u.nome AS autor_comentario,
  c.texto, c.data_comentario
FROM COMENTARIO c
JOIN EXPERIENCIA e ON e.id_experiencia = c.id_experiencia
JOIN UTILIZADOR u ON u.id_utilizador = c.id_utilizador
WHERE e.estado = 'ativa' AND u.estado_conta = 'ativo';

CREATE VIEW vw_destinos_populares AS
SELECT
  d.id_destino, d.pais, d.regiao, d.cidade,
  COUNT(*) AS num_experiencias
FROM DESTINO d
JOIN EXPERIENCIA e ON e.id_destino = d.id_destino
WHERE e.estado = 'ativa'
GROUP BY d.id_destino, d.pais, d.regiao, d.cidade;

CREATE VIEW vw_utilizadores_mais_ativos AS
SELECT
  u.id_utilizador, u.nome, u.email,
  COUNT(*) AS num_experiencias
FROM UTILIZADOR u
JOIN EXPERIENCIA e ON e.id_autor = u.id_utilizador
WHERE u.estado_conta = 'ativo' AND e.estado = 'ativa'
GROUP BY u.id_utilizador, u.nome, u.email;

-- ============================================================================
-- ÍNDICES (Anexo J)
-- ============================================================================

CREATE INDEX idx_experiencia_autor_estado ON EXPERIENCIA(id_autor, estado);
CREATE INDEX idx_experiencia_destino_estado ON EXPERIENCIA(id_destino, estado);
CREATE INDEX idx_experiencia_datas ON EXPERIENCIA(data_inicio, data_fim);
CREATE INDEX idx_experiencia_tipo_estado ON EXPERIENCIA(tipo_experiencia, estado);
CREATE INDEX idx_destino_localizacao ON DESTINO(pais, regiao, cidade);
CREATE INDEX idx_avaliacao_experiencia ON AVALIACAO(id_experiencia, classificacao);
CREATE INDEX idx_multimedia_experiencia ON MULTIMEDIA(id_experiencia, data_upload);
CREATE INDEX idx_comentario_experiencia ON COMENTARIO(id_experiencia, data_comentario);
CREATE INDEX idx_utilizador_estado ON UTILIZADOR(estado_conta);

-- ============================================================================
-- FUNCTION (Anexo K)
-- ============================================================================

DELIMITER $$
CREATE FUNCTION fn_media_avaliacao_experiencia(p_id_experiencia INT)
RETURNS DECIMAL(3,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_media DECIMAL(3,2);
    SELECT AVG(a.classificacao) INTO v_media
    FROM AVALIACAO a
    WHERE a.id_experiencia = p_id_experiencia;
    RETURN COALESCE(v_media, 0);
END$$
DELIMITER ;

-- ============================================================================
-- PROCEDURES (Anexo K)
-- ============================================================================

DELIMITER $$
CREATE PROCEDURE sp_criar_experiencia(
    IN p_id_autor INT,
    IN p_pais VARCHAR(100),
    IN p_regiao VARCHAR(100),
    IN p_cidade VARCHAR(100),
    IN p_titulo VARCHAR(200),
    IN p_descricao TEXT,
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_tipo_experiencia VARCHAR(50)
)
BEGIN
    DECLARE v_id_destino INT;
    IF p_data_fim IS NOT NULL AND p_data_fim < p_data_inicio THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'data_fim tem de ser >= data_inicio';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM UTILIZADOR u WHERE u.id_utilizador = p_id_autor AND u.estado_conta = 'ativo') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Autor inexistente ou inativo';
    END IF;
    SELECT d.id_destino INTO v_id_destino FROM DESTINO d WHERE d.pais = p_pais AND d.cidade = p_cidade AND (d.regiao <=> p_regiao) LIMIT 1;
    IF v_id_destino IS NULL THEN
        INSERT INTO DESTINO(pais, regiao, cidade) VALUES (p_pais, p_regiao, p_cidade);
        SET v_id_destino = LAST_INSERT_ID();
    END IF;
    INSERT INTO EXPERIENCIA(id_autor, id_destino, titulo, descricao, data_inicio, data_fim, tipo_experiencia, data_criacao, estado)
    VALUES (p_id_autor, v_id_destino, p_titulo, p_descricao, p_data_inicio, p_data_fim, p_tipo_experiencia, NOW(), 'ativa');
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_registar_avaliacao(
    IN p_id_utilizador INT,
    IN p_id_experiencia INT,
    IN p_classificacao INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM UTILIZADOR u WHERE u.id_utilizador = p_id_utilizador AND u.estado_conta = 'ativo') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Utilizador inexistente ou inativo';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM EXPERIENCIA e WHERE e.id_experiencia = p_id_experiencia AND e.estado = 'ativa') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Experiência inexistente ou removida';
    END IF;
    IF EXISTS (SELECT 1 FROM AVALIACAO a WHERE a.id_utilizador = p_id_utilizador AND a.id_experiencia = p_id_experiencia) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O utilizador já avaliou esta experiência';
    END IF;
    INSERT INTO AVALIACAO(id_utilizador, id_experiencia, classificacao, data_avaliacao) VALUES (p_id_utilizador, p_id_experiencia, p_classificacao, NOW());
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_adicionar_comentario(
    IN p_id_utilizador INT,
    IN p_id_experiencia INT,
    IN p_texto TEXT
)
BEGIN
    IF p_texto IS NULL OR LENGTH(TRIM(p_texto)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Comentário vazio';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM UTILIZADOR u WHERE u.id_utilizador = p_id_utilizador AND u.estado_conta = 'ativo') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Utilizador inexistente ou inativo';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM EXPERIENCIA e WHERE e.id_experiencia = p_id_experiencia AND e.estado = 'ativa') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Experiência inexistente ou removida';
    END IF;
    INSERT INTO COMENTARIO(id_utilizador, id_experiencia, texto, data_comentario) VALUES (p_id_utilizador, p_id_experiencia, p_texto, NOW());
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_remover_experiencia(
    IN p_id_experiencia INT,
    IN p_id_autor INT
)
BEGIN
    UPDATE EXPERIENCIA SET estado = 'removida' WHERE id_experiencia = p_id_experiencia AND id_autor = p_id_autor AND estado = 'ativa';
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não foi possível remover';
    END IF;
END$$
DELIMITER ;

-- ============================================================================
-- TRIGGERS (Anexo K)
-- ============================================================================

DELIMITER $$
CREATE TRIGGER trg_experiencia_validar_bi
BEFORE INSERT ON EXPERIENCIA
FOR EACH ROW
BEGIN
    IF NEW.data_fim IS NOT NULL AND NEW.data_fim < NEW.data_inicio THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'data_fim >= data_inicio';
    END IF;
    IF NEW.estado IS NULL THEN
        SET NEW.estado = 'ativa';
    END IF;
    IF NEW.estado NOT IN ('ativa', 'removida') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estado inválido';
    END IF;
    IF NEW.tipo_experiencia NOT IN ('cultural','aventura','gastronomica','natureza','urbana') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'tipo_experiencia inválido';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trg_avaliacao_validar_bi
BEFORE INSERT ON AVALIACAO
FOR EACH ROW
BEGIN
    IF NEW.classificacao < 0 OR NEW.classificacao > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'classificacao entre 0 e 5';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM EXPERIENCIA e WHERE e.id_experiencia = NEW.id_experiencia AND e.estado = 'ativa') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Experiência removida';
    END IF;
    SET NEW.data_avaliacao = COALESCE(NEW.data_avaliacao, NOW());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trg_comentario_validar_bi
BEFORE INSERT ON COMENTARIO
FOR EACH ROW
BEGIN
    IF NEW.texto IS NULL OR LENGTH(TRIM(NEW.texto)) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Comentário vazio';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM EXPERIENCIA e WHERE e.id_experiencia = NEW.id_experiencia AND e.estado = 'ativa') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Experiência removida';
    END IF;
    SET NEW.data_comentario = COALESCE(NEW.data_comentario, NOW());
END$$
DELIMITER ;