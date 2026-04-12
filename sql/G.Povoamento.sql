-- ANEXO G. POVOAMENTO DA BD

USE MapaDeMemorias;

-- Inserir Utilizadores
INSERT INTO UTILIZADOR (nome, email, password, biografia, fotografia_perfil, pais_origem, data_registo, estado_conta)
VALUES
('João Silva', 'joao.silva@email.com', '$2y$10$hash123', 'Apaixonado por viagens culturais e história', 'perfil1.jpg', 'Portugal', '2024-01-15 10:30:00', 'ativo'),
('Maria Costa', 'maria.costa@email.com', '$2y$10$hash456', 'Exploradora de novas culturas e sabores', 'perfil2.jpg', 'Brasil', '2024-02-20 14:20:00', 'ativo'),
('Pedro Santos', 'pedro.santos@email.com', '$2y$10$hash789', 'Amante de aventuras nas montanhas', 'perfil3.jpg', 'Portugal', '2024-03-10 09:15:00', 'ativo'),
('Ana Ferreira', 'ana.ferreira@email.com', '$2y$10$hash101', 'Fotógrafa de viagens profissional', 'perfil4.jpg', 'Espanha', '2024-04-05 16:45:00', 'ativo'),
('Carlos Oliveira', 'carlos.oliveira@email.com', '$2y$10$hash112', 'Gastrónomo e crítico de restaurantes', 'perfil5.jpg', 'Portugal', '2024-05-12 11:00:00', 'ativo');

-- Inserir Destinos
INSERT INTO DESTINO (pais, regiao, cidade, latitude, longitude)
VALUES
('Portugal', 'Lisboa', 'Lisboa', 38.722252, -9.139337),
('Portugal', 'Norte', 'Porto', 41.157944, -8.629105),
('Suíça', 'Valais', 'Zermatt', 46.020654, 7.749117),
('França', 'Provença', 'Nice', 43.710173, 7.261953),
('Brasil', 'Rio de Janeiro', 'Rio de Janeiro', -22.906847, -43.172896),
('Portugal', 'Algarve', 'Faro', 37.019356, -7.930439),
('Espanha', 'Catalunha', 'Barcelona', 41.385064, 2.173404);

-- Inserir Experiências
INSERT INTO EXPERIENCIA (id_autor, id_destino, titulo, descricao, data_inicio, data_fim, tipo_experiencia, data_criacao, estado)
VALUES
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

-- Inserir Multimédia
INSERT INTO MULTIMEDIA (id_experiencia, id_utilizador, tipo_ficheiro, caminho_armazenamento, descricao, data_captura, resolucao, tamanho_ficheiro, data_upload)
VALUES
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

-- Inserir Comentários
INSERT INTO COMENTARIO (id_utilizador, id_experiencia, texto, data_comentario)
VALUES
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

-- Inserir Avaliações
INSERT INTO AVALIACAO (id_utilizador, id_experiencia, classificacao, data_avaliacao)
VALUES
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