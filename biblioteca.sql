

-- ============================
-- CRIAÇÃO DAS TABELAS
-- ============================

CREATE TABLE cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(50) NOT NULL
);

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    id_curso INT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE livros (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    ISBN VARCHAR(13) NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    autor VARCHAR(50),
    editora VARCHAR(50)
);

CREATE TABLE exemplar (
    id_exemplar INT PRIMARY KEY AUTO_INCREMENT,
    id_livro INT,
    condicao_fisica VARCHAR(20),
    disponibilidade BOOLEAN,
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

CREATE TABLE emprestimo (
    id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_exemplar INT,
    data_prev_devolucao DATE,
    data_real_devolucao DATE,
    status_emprestimo ENUM('ativo', 'concluido', 'atrasado'),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_exemplar) REFERENCES exemplar(id_exemplar)
);

CREATE TABLE multa (
    id_multa INT PRIMARY KEY AUTO_INCREMENT,
    id_emprestimo INT,
    motivo_multa VARCHAR(30),
    valor DECIMAL(4,2),
    FOREIGN KEY (id_emprestimo) REFERENCES emprestimo(id_emprestimo)
);

-- ============================
-- INSERÇÃO DE DADOS FICTÍCIOS
-- ============================

INSERT INTO cursos (nome_curso) VALUES
('Engenharia de Software'),
('Ciência da Computação');

INSERT INTO usuario (id_curso, nome, email) VALUES
(1, 'Ana Silva', 'ana.silva@email.com'),
(2, 'Carlos Souza', 'carlos.souza@email.com');

INSERT INTO livros (ISBN, titulo, autor, editora) VALUES
('9781234567890', 'Algoritmos em C', 'José da Silva', 'TechBooks'),
('9780987654321', 'Banco de Dados', 'Maria Lima', 'DataPress');

INSERT INTO exemplar (id_livro, condicao_fisica, disponibilidade) VALUES
(1, 'Bom', TRUE),
(2, 'Regular', TRUE);

INSERT INTO emprestimo (id_usuario, id_exemplar, data_prev_devolucao, data_real_devolucao, status_emprestimo) VALUES
(1, 1, '2025-12-05', NULL, 'ativo'),
(2, 2, '2025-11-25', '2025-12-01', 'atrasado');

-- ============================
-- TRIGGER: MULTA AUTOMÁTICA
-- ============================

DELIMITER //
CREATE TRIGGER trg_multa_atraso
AFTER UPDATE ON emprestimo
FOR EACH ROW
BEGIN
    IF NEW.status_emprestimo = 'atrasado' THEN
        INSERT INTO multa (id_emprestimo, motivo_multa, valor)
        VALUES (NEW.id_emprestimo, 'Devolução atrasada', 20.00);
    END IF;
END;
//
DELIMITER ;

-- ============================
-- PROCEDURE: RENOVAR EMPRÉSTIMO
-- ============================

DELIMITER //
CREATE PROCEDURE renovar_emprestimo(IN p_id_emprestimo INT)
BEGIN
    UPDATE emprestimo
    SET data_prev_devolucao = DATE_ADD(data_prev_devolucao, INTERVAL 7 DAY),
        status_emprestimo = 'ativo'
    WHERE id_emprestimo = p_id_emprestimo;
END;
//
DELIMITER ;

-- ============================
-- VIEW: HISTÓRICO DE USUÁRIOS
-- ============================

CREATE VIEW vw_historico_usuario AS
SELECT u.nome AS usuario,
       l.titulo AS livro,
       e.data_prev_devolucao,
       e.data_real_devolucao,
       e.status_emprestimo,
       m.valor AS multa,
       m.motivo_multa
FROM usuario u
JOIN emprestimo e ON u.id_usuario = e.id_usuario
JOIN exemplar ex ON e.id_exemplar = ex.id_exemplar
JOIN livros l ON ex.id_livro = l.id_livro
LEFT JOIN multa m ON e.id_emprestimo = m.id_emprestimo;

-- ============================
-- CONSULTAS DE TESTE
-- ============================

-- 1. Consultar empréstimos ativos
SELECT * FROM emprestimo WHERE status_emprestimo = 'ativo';

-- 2. Renovar empréstimo
CALL renovar_emprestimo(1);

-- 3. Consultar histórico de um usuário
SELECT * FROM vw_historico_usuario WHERE usuario = 'Ana Silva';

-- 4. Ver multas geradas automaticamente
SELECT * FROM multa;
