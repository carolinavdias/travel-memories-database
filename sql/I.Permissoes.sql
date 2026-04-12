-- ANEXO I. UTILIZADORES E PERMISSÕES

-- 1) Criar roles
CREATE ROLE IF NOT EXISTS 'role_admin';
CREATE ROLE IF NOT EXISTS 'role_app';
CREATE ROLE IF NOT EXISTS 'role_readonly';
--(opcional):
-- CREATE ROLE IF NOT EXISTS 'role_moderator';

-- 2) Atribuir permissões às roles
GRANT ALL PRIVILEGES ON MapaDeMemorias.* TO 'role_admin';

GRANT SELECT, INSERT, UPDATE ON MapaDeMemorias.* TO 'role_app';
-- Se a equipa permitir remoções físicas:
-- GRANT DELETE ON MapaDeMemorias.* TO 'role_app';

GRANT SELECT ON MapaDeMemorias.* TO 'role_readonly';

--OPCIONAL: moderador (exemplo genérico)
-- GRANT SELECT, UPDATE ON MapaDeMemorias.EXPERIENCIA TO 'role_moderator';
-- GRANT SELECT, UPDATE ON MapaDeMemorias.MULTIMEDIA   TO 'role_moderator';
-- GRANT SELECT, UPDATE ON MapaDeMemorias.COMENTARIO   TO 'role_moderator';

-- 3) Criar utilizadores (exemplos)
CREATE USER IF NOT EXISTS 'mapamemorias_admin'@'localhost'
    IDENTIFIED BY 'Admin_Str0ngPwd!';
CREATE USER IF NOT EXISTS 'mapamemorias_app'@'localhost'
    IDENTIFIED BY 'App_Str0ngPwd!';
CREATE USER IF NOT EXISTS 'mapamemorias_read'@'localhost'
    IDENTIFIED BY 'Read_Str0ngPwd!';

-- 4) Atribuir roles aos utilizadores
GRANT 'role_admin'    TO 'mapamemorias_admin'@'localhost';
GRANT 'role_app'      TO 'mapamemorias_app'@'localhost';
GRANT 'role_readonly' TO 'mapamemorias_read'@'localhost';

-- 5) Definir role por omissão
SET DEFAULT ROLE 'role_admin'    TO 'mapamemorias_admin'@'localhost';
SET DEFAULT ROLE 'role_app'      TO 'mapamemorias_app'@'localhost';
SET DEFAULT ROLE 'role_readonly' TO 'mapamemorias_read'@'localhost';

-- 6) Aplicar alterações
FLUSH PRIVILEGES;