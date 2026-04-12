-- ANEXO K. PROCEDURES, FUNCTIONS E TRIGGERS

USE MapaDeMemorias;

-- ================================================
-- FUNCTION
-- ================================================
DELIMITER $$

CREATE FUNCTION fn_media_avaliacao_experiencia(
    p_id_experiencia INT
)
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

-- ================================================
-- PROCEDURES
-- ================================================
DELIMITER $$

-- Criação de experiência com get-or-create de DESTINO
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
    -- Validar datas
    IF p_data_fim IS NOT NULL AND p_data_fim < p_data_inicio THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'data_fim tem de ser >= data_inicio';
    END IF;
    -- Garantir autor ativo
    IF NOT EXISTS (
      SELECT 1 FROM UTILIZADOR u
      WHERE u.id_utilizador = p_id_autor
        AND u.estado_conta = 'ativo'
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Autor inexistente ou inativo';
    END IF;
    -- Procurar destino existente
    SELECT d.id_destino INTO v_id_destino
    FROM DESTINO d
    WHERE d.pais = p_pais AND d.cidade = p_cidade
      AND (d.regiao <=> p_regiao)
    LIMIT 1;
    -- Se não existir, criar
    IF v_id_destino IS NULL THEN
         INSERT INTO DESTINO(pais, regiao, cidade)
         VALUES (p_pais, p_regiao, p_cidade);
         SET v_id_destino = LAST_INSERT_ID();
    END IF;
    -- Inserir experiência
    INSERT INTO EXPERIENCIA(
         id_autor, id_destino, titulo, descricao,
         data_inicio, data_fim, tipo_experiencia,
         data_criacao, estado
    ) VALUES (
         p_id_autor, v_id_destino, p_titulo, p_descricao,
         p_data_inicio, p_data_fim, p_tipo_experiencia,
         NOW(), 'ativa'
    );
END$$

-- Registo de avaliação (aplica RC4)
CREATE PROCEDURE sp_registar_avaliacao(
    IN p_id_utilizador INT,
    IN p_id_experiencia INT,
    IN p_classificacao INT
)
BEGIN
    -- Utilizador ativo
    IF NOT EXISTS (
         SELECT 1 FROM UTILIZADOR u
         WHERE u.id_utilizador = p_id_utilizador
           AND u.estado_conta = 'ativo'
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Utilizador inexistente ou inativo';
    END IF;
    -- Experiência ativa
    IF NOT EXISTS (
      SELECT 1 FROM EXPERIENCIA e
      WHERE e.id_experiencia = p_id_experiencia
          AND e.estado = 'ativa'
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Experiência inexistente ou removida';
    END IF;
    -- Impedir segunda avaliação (RC4)
    IF EXISTS (
      SELECT 1 FROM AVALIACAO a
      WHERE a.id_utilizador = p_id_utilizador
          AND a.id_experiencia = p_id_experiencia
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'O utilizador já avaliou esta experiência';
    END IF;
    INSERT INTO AVALIACAO(id_utilizador, id_experiencia,
      classificacao, data_avaliacao)
    VALUES (p_id_utilizador, p_id_experiencia,
      p_classificacao, NOW());
END$$

-- Adicionar comentário
CREATE PROCEDURE sp_adicionar_comentario(
    IN p_id_utilizador INT,
    IN p_id_experiencia INT,
    IN p_texto TEXT
)
BEGIN
    IF p_texto IS NULL OR LENGTH(TRIM(p_texto)) = 0 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Comentário vazio';
    END IF;
    IF NOT EXISTS (
      SELECT 1 FROM UTILIZADOR u
      WHERE u.id_utilizador = p_id_utilizador
        AND u.estado_conta = 'ativo'
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Utilizador inexistente ou inativo';
    END IF;
    IF NOT EXISTS (
      SELECT 1 FROM EXPERIENCIA e
      WHERE e.id_experiencia = p_id_experiencia
        AND e.estado = 'ativa'
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Experiência inexistente ou removida';
    END IF;
    INSERT INTO COMENTARIO(id_utilizador, id_experiencia,
      texto, data_comentario)
    VALUES (p_id_utilizador, p_id_experiencia,
      p_texto, NOW());
END$$

-- Soft delete da experiência
CREATE PROCEDURE sp_remover_experiencia(
    IN p_id_experiencia INT,
    IN p_id_autor INT
)
BEGIN
    UPDATE EXPERIENCIA
    SET estado = 'removida'
    WHERE id_experiencia = p_id_experiencia
      AND id_autor = p_id_autor
      AND estado = 'ativa';
    IF ROW_COUNT() = 0 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Não foi possível remover';
    END IF;
END$$

DELIMITER ;

-- ================================================
-- TRIGGERS
-- ================================================
DELIMITER $$

-- Validar EXPERIENCIA antes de inserir
CREATE TRIGGER trg_experiencia_validar_bi
BEFORE INSERT ON EXPERIENCIA
FOR EACH ROW
BEGIN
    IF NEW.data_fim IS NOT NULL
        AND NEW.data_fim < NEW.data_inicio THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'data_fim >= data_inicio';
    END IF;
    IF NEW.estado IS NULL THEN
      SET NEW.estado = 'ativa';
    END IF;
    IF NEW.estado NOT IN ('ativa', 'removida') THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Estado inválido';
    END IF;
    IF NEW.tipo_experiencia NOT IN
          ('cultural','aventura','gastronomica','natureza','urbana')
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'tipo_experiencia inválido';
    END IF;
END$$

-- Validar AVALIACAO antes de inserir
CREATE TRIGGER trg_avaliacao_validar_bi
BEFORE INSERT ON AVALIACAO
FOR EACH ROW
BEGIN
    IF NEW.classificacao < 0 OR NEW.classificacao > 5 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'classificacao entre 0 e 5';
    END IF;
    IF NOT EXISTS (
      SELECT 1 FROM EXPERIENCIA e
      WHERE e.id_experiencia = NEW.id_experiencia
          AND e.estado = 'ativa'
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Experiência removida';
    END IF;
    SET NEW.data_avaliacao = COALESCE(NEW.data_avaliacao, NOW());
END$$

-- Validar COMENTARIO antes de inserir
CREATE TRIGGER trg_comentario_validar_bi
BEFORE INSERT ON COMENTARIO
FOR EACH ROW
BEGIN
    IF NEW.texto IS NULL OR LENGTH(TRIM(NEW.texto)) = 0 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Comentário vazio';
    END IF;
    IF NOT EXISTS (
      SELECT 1 FROM EXPERIENCIA e
      WHERE e.id_experiencia = NEW.id_experiencia
          AND e.estado = 'ativa'
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Experiência removida';
    END IF;
    SET NEW.data_comentario = COALESCE(NEW.data_comentario, NOW());
END$$

DELIMITER ;