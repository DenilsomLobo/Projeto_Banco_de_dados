CREATE DATABASE IF NOT EXISTS cafeteria
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

CREATE TABLE produto(
    id_produto INT NULL AUTO_INCREMENT,
    produto_nome VARCHAR (50),
    produto_quantidade_estoque INT (4),
    produto_valor DECIMAL (3,2),
    PRIMARY KEY (id_produto)
) DEFAULT CHARSET = utf8;

CREATE TABLE funcionario (
    id_funcionario INT NULL AUTO_INCREMENT,
    funcionario_nome VARCHAR (50),
    funcionario_cpf VARCHAR (11),
    funcionario_setor VARCHAR (50),
    PRIMARY KEY (id_funcionario)
) DEFAULT CHARSET = utf8;

CREATE TABLE cliente (
    id_cliente INT NULL AUTO_INCREMENT,
    cliente_nome VARCHAR (50),
    cliente_cpf VARCHAR (11),
    PRIMARY KEY (id_cliente)
) DEFAULT CHARSET= utf8;

CREATE TABLE pedido (
    id_pedido INT NOT NULL AUTO_INCREMENT,
    pedido_data DATETIME,
    pedido_quantidade INT (4),
    pedido_forma_pagamento ENUM ('dinheiro', 'credito', 'debito'),
    PRIMARY KEY (id_pedido)
) DEFAULT CHARSET = utf8;

CREATE TABLE atendimento(
    id_atendimento INT NOT NULL AUTO_INCREMENT,
    atendimento_data DATE,
    PRIMARY KEY (id_atendimento)
) DEFAULT CHARSET = utf8;

ALTER TABLE pedido ADD COLUMN id_produto INT;
ALTER TABLE pedido ADD COLUMN id_cliente INT;

ALTER TABLE pedido ADD FOREIGN KEY (id_produto)
REFERENCES produto(id_produto);
ALTER TABLE pedido ADD FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

ALTER TABLE atendimento ADD COLUMN id_pedido INT;
ALTER TABLE atendimento ADD COLUMN id_funcionario INT;
ALTER TABLE atendimento ADD COLUMN id_cliente INT;

ALTER TABLE atendimento ADD FOREIGN KEY (id_pedido)
REFERENCES pedido(id_pedido);
ALTER TABLE atendimento ADD FOREIGN KEY (id_funcionario)
REFERENCES funcionario(id_funcionario);
ALTER TABLE atendimento ADD FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente);

INSERT INTO produto VALUES
(DEFAULT, 'Café', 50, 9.60),
(DEFAULT, 'Sorteve na taça', 25, 25.00),
(DEFAULT, 'Suco natural', 33, 5.00),
(DEFAULT, 'Pão de queijo', 20, 9.00),
(DEFAULT, 'Misto-quente', 50, 9.60),
(DEFAULT, 'Bolo', 36, 4.50);

INSERT INTO funcionario VALUES
(DEFAULT, 'Thiago', '10456020722', 'Atendente'),
(DEFAULT, 'Caio', '10485240321', 'Atendente'),
(DEFAULT, 'Patricio', '42018063055', 'Atendente'),
(DEFAULT, 'Sebastião', '52698742655', 'Atendente'),
(DEFAULT, 'Teteia', '05674114988', 'Caixa'),
(DEFAULT, 'Selena', '09512398011', 'Garçon'),
(DEFAULT, 'Anita', '78957423622', 'Garçon'),
(DEFAULT, 'Severino', '15932685244', 'Serviços gerais');

INSERT INTO cliente VALUES
(DEFAULT, 'Luva de Predreiro', '48952396722'),
(DEFAULT, 'Raú Gil', '48952396722'),
(DEFAULT, 'Nicole Martins', '15897566633'),
(DEFAULT, 'Fabio Sucurilo', '15896322265'),
(DEFAULT, 'Ricardo Bretão', '15963515688'),
(DEFAULT, 'Léo Lins', '15896336444');

INSERT INTO pedido VALUES
(DEFAULT, '1984-04-15 14:10:05', 2, 'dinheiro', 1, 3),
(DEFAULT, '1984-06-20 19:25:06', 5, 'credito', 3, 2),
(DEFAULT, '1985-09-21 14:10:05', 1, 'dinheiro', 2, 1),
(DEFAULT, '1985-10-26 14:10:05', 4, 'debito', 6, 4),
(DEFAULT, '1985-11-14 14:10:05', 6, 'dinheiro', 4, 5),
(DEFAULT, '1984-08-13 12:15:05', 3, 'debito', 5, 6);

INSERT INTO atendimento VALUES
(DEFAULT, '1984-04-15 14:10:05', 1, 1, 3),
(DEFAULT, '1984-06-20 19:25:06', 2, 2, 2),
(DEFAULT, '1985-09-21 14:10:05', 3, 3, 1),
(DEFAULT, '1985-10-26 14:10:05', 4, 4, 4),
(DEFAULT, '1985-11-14 14:10:05', 5, 4, 5),
(DEFAULT, '1984-08-13 12:15:05', 6, 1, 6);

SELECT
pedido.pedido_data,
pedido.pedido_quantidade,
pedido.pedido_forma_pagamento,
atendimento.atendimento_data,
funcionario.funcionario_nome,
funcionario.funcionario_setor,
cliente.cliente_nome,
cliente.cliente_cpf 
FROM pedido
JOIN atendimento ON pedido.id_pedido = atendimento.id_pedido
JOIN cliente ON cliente.id_cliente = atendimento.id_cliente
JOIN funcionario ON funcionario.id_funcionario = atendimento.id_funcionario;

/**/
SELECT
cliente.id_cliente,
cliente.cliente_nome,
cliente.cliente_cpf,
produto.id_produto,
produto.produto_nome,
produto.produto_quantidade_estoque,
produto.produto_valor,
pedido.id_pedido,
pedido.pedido_data,
pedido.pedido_quantidade,
pedido.pedido_forma_pagamento,
pedido.id_produto,
pedido.id_cliente
FROM pedido
JOIN cliente ON pedido.id_cliente = cliente.id_cliente
JOIN produto ON pedido.id_produto = produto.id_produto;