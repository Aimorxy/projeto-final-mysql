CREATE DATABASE  Pastelaria;
USE Pastelaria;
-- cria tabela

CREATE TABLE clientes (
    id_cliente int primary key auto_increment,
    nome_completo varchar(100),
    apelido varchar(50),
    cpf VARCHAR(14) unique,
    data_nascimento date,
    telefone varchar(15),
    email varchar(100),
    bairro varchar(100),
    cidade varchar(50),
    estado varchar(2)
);

CREATE TABLE categoria (
    id_categoria int primary key auto_increment,
    nome varchar(50),
    total_vendas INT DEFAULT 0
);

CREATE TABLE forma_pagamentos (
    id_forma_pagamento int primary key auto_increment,
    nome varchar(50)
);

CREATE TABLE recheio (
    id_recheio int primary key auto_increment,
    nome varchar(100)
);

CREATE TABLE pedidos (
    id_pedido int primary key auto_increment,
    data_pedido date default (CURRENT_DATE),
    id_cliente int not null,
    id_forma_pagamento int not null,
    foreign key(id_forma_pagamento) references forma_pagamentos(id_forma_pagamento),
    foreign key(id_cliente) references clientes(id_cliente)
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    preco DECIMAL(8,2),
    tamanho VARCHAR(50),
    id_categoria INT NOT NULL,
    id_recheio INT NULL,
    quantidade_em_estoque INT DEFAULT 0,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    FOREIGN KEY (id_recheio) REFERENCES recheio(id_recheio)
);

CREATE TABLE recheio_produto (
    id_recheio_produto int primary key auto_increment,
    id_recheio int not null,
    id_produto int not null,
    foreign key(id_recheio) references recheio(id_recheio),
    foreign key(id_produto) references produto(id_produto)
);

CREATE TABLE itens_pedido (
    id_item int primary key auto_increment,
    id_pedido int not null,
    id_produto int not null,
    quantidade int not null,
    foreign key(id_pedido) references pedidos(id_pedido),
    foreign key(id_produto) references produto(id_produto)
);

INSERT INTO recheio(nome)
VALUES 
    ('carne'),
    ('frango'),
    ('queijo'),
    ('palmito'),
    ('espinafre'),
    ('camarão'),
    ('bacalhau'),
    ('Pastel de Queijo e Cheesecake'),
    ('Queijo com Goiabada'),
    ('Queijo e Milho'),
    ('Bacon');

INSERT INTO categoria(nome)
VALUES 
    ('simples'),
    ('vegano'),
    ('vegetariano'),
    ('zero lactose'),
    ('bebida');

INSERT INTO forma_pagamentos(nome)
VALUES 
    ('dinheiro'),
    ('pix'),
    ('cartão debito'),
    ('cartão credito'),
    ('vale alimentacão');
    

DELIMITER !PROCEDIMENTO!
-- Procedimento para adicionar novos clientes à tabela de clientes.
CREATE PROCEDURE AddClientes(
    IN nome_completo VARCHAR(100),
    IN apelido VARCHAR(50),
    IN cpf VARCHAR(14),
    IN data_nascimento DATE,
    IN telefone VARCHAR(15),
    IN email VARCHAR(100),
    IN bairro VARCHAR(100),
    IN cidade VARCHAR(50),
    IN estado VARCHAR(2)
) BEGIN
    INSERT INTO clientes (nome_completo, apelido, cpf, data_nascimento, telefone, email, bairro, cidade, estado) 
    VALUES (nome_completo, apelido, cpf, data_nascimento, telefone, email, bairro, cidade, estado);
END  !PROCEDIMENTO!
-- Procedimento para adicionar novos produtos à tabela de produtos.
CREATE PROCEDURE AddProdutos(   
    IN nome VARCHAR(50),
    IN preco DECIMAL(8,2),
    IN tamanho VARCHAR(50),
    IN id_categoria INT,
    IN id_recheio INT 
) BEGIN
    IF id_recheio IS NULL THEN
        SET id_recheio = null; 
    END IF;
    IF id_recheio IS NULL THEN
        INSERT INTO produto (nome, preco, tamanho, id_categoria) 
        VALUES (nome, preco, tamanho, id_categoria);
    ELSE
        INSERT INTO produto (nome, preco, tamanho, id_categoria, id_recheio) 
        VALUES (nome, preco, tamanho, id_categoria, id_recheio);
    END IF;
END !PROCEDIMENTO!
-- Procedimento para associar recheios a produtos na tabela de recheio_produto.
CREATE PROCEDURE AddRecheios(
    IN id_recheio INT,
    IN id_produto INT
) BEGIN
    INSERT INTO recheio_produto (id_produto, id_recheio) 
    VALUES (id_produto, id_recheio);
END !PROCEDIMENTO!
DELIMITER ;

-- inserindo dados dos clientes
CALL AddClientes('Reginaldo Henrique', 'Reginaldo', '123.456.784-01', '2001-03-09', '235123431', 'rodrigo@email.com', 'humildes', 'FSA', 'BA');
CALL AddClientes('Carlos henrique', 'Carlos', '345.609.342-01', '2003-08-03', '750304859', 'carlos@email.com', 'Aviario', 'FSA', 'BA');
CALL AddClientes('Yasmin nere', 'Yasmin', '503.987.545-01', '2004-03-14', '75395030', 'carlos@email.com', 'feira 7', 'FSA', 'BA');
CALL AddClientes('Lucia Oliveira', 'Lucia', '789.456.123-45', '2008-09-25', '987654321', 'lucia@email.com', 'Centro', 'FSA', 'BA');
CALL AddClientes('0 Santos', '0', '987.654.321-01', '2010-03-12', '654321987', '0@email.com', 'Bairro Alegre', 'FSA', 'BA');
CALL AddClientes('Camila Silva', 'Camila', '234.567.890-12', '2009-08-18', '876543210', 'camila@email.com', 'Nova Cidade', 'FSA', 'BA');
CALL AddClientes('Gustavo Henrique', 'Gustavo', '123.456.789-01', '2005-05-09', '123456789', 'gustavo@email.com', 'Centro', 'FSA', 'BA');
CALL AddClientes('Vitor Hugo', 'Vitor', '345.609.456-01', '2000-04-03', '12333124', 'vitor@email.com', 'Aviario', 'FSA', 'BA');
CALL AddClientes('Luiz Felipe', 'Luiz', '123.456.123-45', '2008-09-25', '987654321', 'luiz@email.com', 'Centro', 'FSA', 'BA');
CALL AddClientes('Julio Henrique', 'Julio', '768.609.456-01', '2000-04-03', '12333124', 'vitor@email.com', 'Aviario', 'FSA', 'BA');
CALL AddClientes('Fabio Felipe', 'Fabio', '987.456.123-45', '2008-09-25', '987654321', 'luiz@email.com', 'Centro', 'FSA', 'BA');
CALL AddClientes('Zélia Silva', 'Zélia', '433.609.456-01', '2000-04-03', '12333124', 'vitor@email.com', 'Aviario', 'FSA', 'BA');

-- inserindo dados dos produtos
CALL AddProdutos('Suco de laranja', 2.00, '1L', 5, null);
CALL AddProdutos('Suco de laranja', 5.00, '2L', 5, null);
CALL AddProdutos('Refrigerante de cola', 3.50, '1L', 5, null);
CALL AddProdutos('Refrigerante de guaraná', 4.00, '1L', 5, null);
CALL AddProdutos('Refrigerante de fanta', 6.00, '2L', 5, null);
CALL AddProdutos('Suco de acerola', 7.00, '2L', 5, null);
CALL AddProdutos('Limonada', 3.50, '1L', 5, null);
CALL AddProdutos('Tubaina', 1.50, '350 ML', 5, null);
CALL AddProdutos('Pastel de carne', 5.00, 'M', 1, 1);
CALL AddProdutos('Pastel de frango', 6.00, 'G', 1, 2);
CALL AddProdutos('Pastel de queijo', 6.00, 'G', 1, 3);
CALL AddProdutos('Pastel de palmito', 3.00, 'P', 2, 4);
CALL AddProdutos('Pastel de queijo cheeder', 6.00, 'G', 1, 3);
CALL AddProdutos('Pastel de espinafre', 5.50, 'G', 2, 5);
CALL AddProdutos('Pastel de queijo e goiabada', 6.50, 'M', 4, 9);
CALL AddProdutos('Pastel de camarão', 6.50, 'M', 4, 6);
CALL AddProdutos('Pastel de bacalhau', 6.50, 'M', 4, 7);
CALL AddProdutos('Pastel de bacon', 6.50, 'M', 4, 11);
CALL AddProdutos('Pastel de bacon grande', 7.00, 'G', 4, 11);
CALL AddProdutos('Pastel de milho', 6.50, 'M', 4, 10);

-- inserindo dados dos recheios
CALL AddRecheios(1, 1);
CALL AddRecheios(2, 2);
CALL AddRecheios(3, 3);
CALL AddRecheios(4, 4);
CALL AddRecheios(5, 5);
CALL AddRecheios(6, 6);
CALL AddRecheios(7, 7);
CALL AddRecheios(8, 8);
CALL AddRecheios(9, 9);
CALL AddRecheios(10, 10);
CALL AddRecheios(11, 11);

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (1, 1);
SET @id_pedido_0 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_0, 3, 2);  
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_0, 11, 1);  
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (1, 2);
SET @id_pedido_0 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_0, 11, 2);  
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_0, 12, 1);  
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (1, 1);
SET @id_pedido_1 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_1, 10, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_1, 12, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (3, 2);
SET @id_pedido_1 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_1, 15, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_1, 10, 5);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (4, 2);
SET @id_pedido_2 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_2, 11, 3);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_2, 13, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (6, 1);
SET @id_pedido_3 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_3, 7, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_3, 6, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (9, 1);
SET @id_pedido_4 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_4, 10, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_4, 13, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (10, 1);
SET @id_pedido_5 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_5, 12, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_5, 14, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (8, 1);
SET @id_pedido_6 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_6, 11, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_6, 6, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (7, 1);
SET @id_pedido_7 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_7, 14, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_7, 3, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (6, 1);
SET @id_pedido_8 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_8, 10, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_8, 12, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (9, 1);
SET @id_pedido_9 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_9, 13, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_9, 15, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (7, 1);
SET @id_pedido_10 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_10, 11, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_10, 10, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (6, 1);
SET @id_pedido_11 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_11, 12, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_11, 7, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_11, 6, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (9, 1);
SET @id_pedido_12 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_12, 10, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_12, 13, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (10, 1);
SET @id_pedido_13 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_13, 12, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_13, 14, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (8, 1);
SET @id_pedido_14 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_14, 11, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_14, 6, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (7, 1);
SET @id_pedido_15 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_15, 14, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_15, 3, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (6, 1);
SET @id_pedido_16 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_16, 10, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_16, 12, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (9, 1);
SET @id_pedido_17 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_17, 13, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_17, 15, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (7, 1);
SET @id_pedido_18 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_18, 11, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_18, 10, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (6, 1);
SET @id_pedido_19 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_19, 12, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_19, 14, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (9, 1);
SET @id_pedido_20 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_20, 11, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_20, 6, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (1, 1);
SET @id_pedido_01 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_01, 3, 2);  
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_01, 11, 1);  
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (1, 2);
SET @id_pedido_02 = LAST_INSERT_ID();

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_02, 11, 2);  
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_02, 12, 1);  
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (1, 1);
SET @id_pedido_03 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_03, 10, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_03, 12, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (3, 2);
SET @id_pedido_04 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_04, 15, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_04, 10, 5);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (4, 2);
SET @id_pedido_05 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_05, 11, 3);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_05, 13, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (6, 1);
SET @id_pedido_06 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_06, 7, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_06, 6, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (9, 1);
SET @id_pedido_07 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_07, 10, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_07, 13, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (10, 1);
SET @id_pedido_08 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_08, 12, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_08, 14, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (8, 1);
SET @id_pedido_09 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_09, 11, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_09, 6, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (7, 1);
SET @id_pedido_010 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_010, 14, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_010, 3, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (6, 1);
SET @id_pedido_011 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_011, 10, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_011, 12, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (9, 1);
SET @id_pedido_012 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_012, 13, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_012, 15, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (7, 1);
SET @id_pedido_013 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_013, 11, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_013, 10, 2);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (6, 1);
SET @id_pedido_014 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_014, 12, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_014, 7, 2);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_014, 6, 1);
COMMIT;

START TRANSACTION;
INSERT INTO pedidos (id_cliente, id_forma_pagamento) VALUES (9, 1);
SET @id_pedido_015 = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_015, 10, 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES (@id_pedido_015, 13, 2);
COMMIT;


DELIMITER !GATILHO!
-- Trigger que verifica se um novo cliente tem pelo menos 18 anos antes de inseri-lo na tabela de clientes.
CREATE TRIGGER VerificarIdade
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF DATEDIFF(CURRENT_DATE(), NEW.data_nascimento) < 6570 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Clientes devem ter pelo menos 18 anos.';
    END IF;
END;
!GATILHO!
-- Trigger que atualiza o estoque do produto após a inserção de um novo item de pedido.
CREATE TRIGGER AtualizarEstoque
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE produto
    SET quantidade_em_estoque = quantidade_em_estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto
    AND quantidade_em_estoque >= NEW.quantidade;
END;
!GATILHO!
-- Trigger que impede a exclusão de clientes que possuem pedidos pendentes.
CREATE TRIGGER VerificarPagamentosPendentes
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    DECLARE total_pagamentos INT;
    SELECT COUNT(*) INTO total_pagamentos
    FROM pedidos
    WHERE id_cliente = OLD.id_cliente;
    IF total_pagamentos > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir clientes com pagamentos pendentes.';
    END IF;
END;
!GATILHO!
-- Trigger que atualiza o total de vendas de uma categoria sempre que um novo item de pedido é inserido.
CREATE TRIGGER AtualizarTotalVendas
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE categoria
    SET total_vendas = total_vendas + NEW.quantidade
    WHERE id_categoria = (
        SELECT id_categoria
        FROM produto
        WHERE id_produto = NEW.id_produto
    );
END;
!GATILHO!
-- Trigger que impede a atualização de preços de produtos para valores negativos ou nulos.
CREATE TRIGGER EvitarPrecosNegativos
BEFORE UPDATE ON produto
FOR EACH ROW
BEGIN
    IF NEW.preco <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido definir preços negativos ou nulos.';
    END IF;
END;
!GATILHO!
DELIMITER ;

-- Consulta de Total de Pedidos por Cliente e Mês:
SELECT 
    cl.id_cliente,
    cl.nome_completo,
    MONTH(pe.data_pedido) 
AS  
    mes,
    COUNT(pe.id_pedido)
AS 
    total_pedidos 
FROM clientes cl
JOIN pedidos pe ON cl.id_cliente = pe.id_cliente
WHERE YEAR(pe.data_pedido) = YEAR(CURDATE())
GROUP BY cl.id_cliente, mes
ORDER BY total_pedidos DESC;

-- Consulta do Valor Total de Vendas
SELECT SUM(preco * quantidade) AS valor_total_venda FROM produto
JOIN itens_pedido ON produto.id_produto = itens_pedido.id_produto;

-- Consulta de Quantidade de Vendas por Produto (em ordem crescente)
SELECT p.nome 
AS 
    pastel,
    COUNT(ip.id_item)
AS quantidade_vendas
FROM produto p
JOIN itens_pedido ip ON p.id_produto = ip.id_produto
GROUP BY p.nome
ORDER BY quantidade_vendas ASC;

-- Consulta de Pedidos de Pastéis por Clientes Maiores de 18 Anos
SELECT
    pe.id_pedido,
    p.nome AS nome_do_pastel,
    cl.nome_completo,
    TIMESTAMPDIFF(YEAR, cl.data_nascimento, CURDATE()) AS idade
FROM produto p
JOIN categoria c ON p.id_categoria = c.id_categoria
JOIN recheio_produto rp ON p.id_produto = rp.id_produto
JOIN recheio r ON rp.id_recheio = r.id_recheio
JOIN itens_pedido ip ON p.id_produto = ip.id_produto
JOIN pedidos pe ON ip.id_pedido = pe.id_pedido
JOIN clientes cl ON pe.id_cliente = cl.id_cliente
WHERE
    c.id_categoria = 2 
AND TIMESTAMPDIFF(YEAR, cl.data_nascimento, CURDATE()) > 18;

-- Liste todos os pastéis que possuem bacon e/ou queijo em seu recheio.
SELECT 
    nome AS nome_pastel
FROM recheio_produto AS rp
JOIN produto AS pr ON pr.id_produto = rp.id_produto
WHERE pr.id_recheio IN (11, 3);
select*from recheio_produto;

-- Liste quais são os pastéis mais vendidos, incluindo a quantidade de vendas em ordem decrescente.
SELECT p.*
FROM pedidos p
WHERE EXISTS (
    SELECT 1
    FROM itens_pedido ip
    JOIN produto pr ON ip.id_produto = pr.id_produto
    WHERE pr.id_categoria IN (1, 2)  
      AND ip.id_pedido = p.id_pedido
)
AND EXISTS (
    SELECT 1
    FROM itens_pedido ip2
    JOIN produto pr2 ON ip2.id_produto = pr2.id_produto
    WHERE pr2.id_categoria = 5  
      AND ip2.id_pedido = p.id_pedido
);

-- Liste os nomes de todos os pastéis veganos vendidos para pessoas com mais de 18 anos.
SELECT
    p.nome AS nome_do_pastel
FROM
    produto p
JOIN categoria c ON p.id_categoria = c.id_categoria
JOIN recheio_produto rp ON p.id_produto = rp.id_produto
JOIN recheio r ON rp.id_recheio = r.id_recheio
JOIN itens_pedido ip ON p.id_produto = ip.id_produto
JOIN pedidos pe ON ip.id_pedido = pe.id_pedido
JOIN clientes cl ON pe.id_cliente = cl.id_cliente
WHERE
    c.id_categoria = 2 
    AND TIMESTAMPDIFF(YEAR, cl.data_nascimento, CURDATE()) > 18;

-- Liste os clientes com maior número de pedidos realizados em 1 ano agrupados por mês
SELECT 
    cl.id_cliente,
    cl.nome_completo,
    MONTH(pe.data_pedido) AS mes,
    COUNT(pe.id_pedido) AS total_pedidos
FROM clientes cl
JOIN pedidos pe ON cl.id_cliente = pe.id_cliente
WHERE  YEAR(pe.data_pedido) = YEAR(CURDATE())
GROUP BY cl.id_cliente, mes
ORDER BY total_pedidos DESC;

-- Retorna a quantidade total de pedidos realizados por cada cliente no último mês:
SELECT cl.nome_completo AS cliente, COUNT(pe.id_pedido) AS total_pedidos
FROM clientes cl
JOIN pedidos pe ON cl.id_cliente = pe.id_cliente
WHERE MONTH(pe.data_pedido) = MONTH(CURRENT_DATE()) AND YEAR(pe.data_pedido) = YEAR(CURRENT_DATE())
GROUP BY cl.id_cliente, cliente
ORDER BY total_pedidos DESC;

-- Lista todos os clientes e seus pedidos:
CREATE VIEW vw_clientes_pedidos AS
SELECT c.id_cliente AS cliente_id, c.nome_completo, c.apelido, c.cpf, c.data_nascimento, c.telefone, c.email, c.bairro, c.cidade, c.estado,
       p.id_pedido, p.data_pedido, p.id_cliente AS pedido_cliente_id, p.id_forma_pagamento
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente;
SELECT cliente_id, nome_completo, apelido, cpf, data_nascimento, telefone, email, bairro, cidade, estado,
       id_pedido, data_pedido, pedido_cliente_id, id_forma_pagamento
FROM vw_clientes_pedidos;

-- Produtos mais vendidos:
CREATE VIEW vw_produtos_mais_vendidos AS
SELECT pr.nome, c.total_vendas AS total_vendido
FROM produto pr
JOIN categoria c ON pr.id_categoria = c.id_categoria
ORDER BY total_vendido DESC;
SELECT nome, total_vendido
FROM vw_produtos_mais_vendidos;

-- Clientes com mais de 18 anos:
CREATE VIEW vw_pedidos_adultos AS
SELECT p.*
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE YEAR(CURRENT_DATE()) - YEAR(c.data_nascimento) >= 18;

-- Recheios Populares:
CREATE VIEW vw_recheios_populares AS
SELECT r.nome, COUNT(rp.id_produto) AS total_utilizado
FROM recheio r
JOIN recheio_produto rp ON r.id_recheio = rp.id_recheio
GROUP BY r.nome
ORDER BY total_utilizado DESC;

-- Produtos Sem Venda:
CREATE VIEW vw_produtos_sem_venda AS
SELECT pr.nome
FROM produto pr
LEFT JOIN itens_pedido ip ON pr.id_produto = ip.id_produto
WHERE ip.id_produto IS NULL;

-- Clientes que mais compram bebidas:
CREATE VIEW vw_clientes_mais_pedem_bebidas AS
SELECT c.nome_completo, COUNT(ip.id_produto) AS total_bebidas
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produto pr ON ip.id_produto = pr.id_produto
WHERE pr.id_categoria = 5  
GROUP BY c.nome_completo
ORDER BY total_bebidas DESC;

-- Pedidos realizados no último Mês:
CREATE VIEW vw_pedidos_ultimo_mes AS
SELECT *
FROM pedidos
WHERE MONTH(data_pedido) = MONTH(CURRENT_DATE()) AND YEAR(data_pedido) = YEAR(CURRENT_DATE());

-- Clientes e seus Pedidos no último Mês:
CREATE VIEW vw_clientes_pedidos_ultimo_mes AS
SELECT c.id_cliente AS cliente_id, c.nome_completo, c.apelido, c.cpf, c.data_nascimento, c.telefone, c.email, c.bairro, c.cidade, c.estado,
       p.id_pedido, p.data_pedido, p.id_cliente AS pedido_cliente_id, p.id_forma_pagamento
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE MONTH(p.data_pedido) = MONTH(CURRENT_DATE()) AND YEAR(p.data_pedido) = YEAR(CURRENT_DATE());

-- Total de Vendas por Categoria no último Mês:
CREATE VIEW vw_total_vendas_categoria_ultimo_mes AS
SELECT c.nome AS categoria, SUM(ip.quantidade) AS total_vendido
FROM categoria c
JOIN produto pr ON c.id_categoria = pr.id_categoria
LEFT JOIN itens_pedido ip ON pr.id_produto = ip.id_produto
LEFT JOIN pedidos p ON ip.id_pedido = p.id_pedido
WHERE MONTH(p.data_pedido) = MONTH(CURRENT_DATE()) AND YEAR(p.data_pedido) = YEAR(CURRENT_DATE())
GROUP BY c.nome
ORDER BY total_vendido DESC;

-- Total de Vendas por Categoria no último ano:
CREATE VIEW Total_Vendas_Por_Categoria_Ultimo_Ano AS
SELECT 
    c.nome AS categoria,
    YEAR(p.data_pedido) AS ano,
    COUNT(ip.id_item) AS total_vendas
FROM pedidos p
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produto pr ON ip.id_produto = pr.id_produto
JOIN categoria c ON pr.id_categoria = c.id_categoria
WHERE YEAR(p.data_pedido) = YEAR(CURDATE()) - 1
GROUP BY c.nome, YEAR(p.data_pedido)
ORDER BY c.nome, YEAR(p.data_pedido);