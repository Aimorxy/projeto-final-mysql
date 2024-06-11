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