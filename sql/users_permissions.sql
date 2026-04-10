-- ============================================
-- Mapa de Memórias — Users & Permissions
-- Bases de Dados 2025/2026 — UMinho
-- ============================================

USE MapaDeMemorias;

-- Criar roles
CREATE ROLE IF NOT EXISTS 'role_admin';
CREATE ROLE IF NOT EXISTS 'role_app';
CREATE ROLE IF NOT EXISTS 'role_readonly';

-- Atribuir permissões às roles
GRANT ALL PRIVILEGES ON MapaDeMemorias.* TO 'role_admin';
GRANT SELECT, INSERT, UPDATE ON MapaDeMemorias.* TO 'role_app';
GRANT SELECT ON MapaDeMemorias.* TO 'role_readonly';

-- Criar utilizadores
CREATE USER IF NOT EXISTS 'mapamemorias_admin'@'localhost' IDENTIFIED BY 'Admin_Str0ngPwd!';
CREATE USER IF NOT EXISTS 'mapamemorias_app'@'localhost' IDENTIFIED BY 'App_Str0ngPwd!';
CREATE USER IF NOT EXISTS 'mapamemorias_read'@'localhost' IDENTIFIED BY 'Read_Str0ngPwd!';

-- Atribuir roles aos utilizadores
GRANT 'role_admin' TO 'mapamemorias_admin'@'localhost';
GRANT 'role_app' TO 'mapamemorias_app'@'localhost';
GRANT 'role_readonly' TO 'mapamemorias_read'@'localhost';

-- Definir role por omissão
SET DEFAULT ROLE 'role_admin' TO 'mapamemorias_admin'@'localhost';
SET DEFAULT ROLE 'role_app' TO 'mapamemorias_app'@'localhost';
SET DEFAULT ROLE 'role_readonly' TO 'mapamemorias_read'@'localhost';

FLUSH PRIVILEGES;
