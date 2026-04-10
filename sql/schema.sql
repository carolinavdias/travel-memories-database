-- ============================================
-- Mapa de Memórias — Schema
-- Bases de Dados 2025/2026 — UMinho
-- ============================================

DROP DATABASE IF EXISTS MapaDeMemorias;
CREATE DATABASE IF NOT EXISTS MapaDeMemorias
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE MapaDeMemorias;

-- Tabela UTILIZADOR
CREATE TABLE IF NOT EXISTS UTILIZADOR (
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

-- Tabela DESTINO
CREATE TABLE IF NOT EXISTS DESTINO (
    id_destino INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(80) NOT NULL,
    regiao VARCHAR(80),
    cidade VARCHAR(120) NOT NULL,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    PRIMARY KEY(id_destino),
    UNIQUE KEY unique_location (pais, regiao, cidade)
) ENGINE = InnoDB;

-- Tabela EXPERIENCIA
CREATE TABLE IF NOT EXISTS EXPERIENCIA (
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

-- Tabela MULTIMEDIA
CREATE TABLE IF NOT EXISTS MULTIMEDIA (
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

-- Tabela COMENTARIO
CREATE TABLE IF NOT EXISTS COMENTARIO (
    id_comentario INT NOT NULL AUTO_INCREMENT,
    id_utilizador INT NOT NULL,
    id_experiencia INT NOT NULL,
    texto TEXT NOT NULL,
    data_comentario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_comentario),
    FOREIGN KEY(id_utilizador) REFERENCES UTILIZADOR(id_utilizador) ON DELETE CASCADE,
    FOREIGN KEY(id_experiencia) REFERENCES EXPERIENCIA(id_experiencia) ON DELETE CASCADE
) ENGINE = InnoDB;

-- Tabela AVALIACAO
CREATE TABLE IF NOT EXISTS AVALIACAO (
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
