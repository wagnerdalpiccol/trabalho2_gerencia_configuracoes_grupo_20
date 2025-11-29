
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS produtos CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;


CREATE TABLE IF NOT EXISTS clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL
);


INSERT INTO clientes (nome, email, status) VALUES
('Ana Silva', 'ana@exemplo.com', 'Ativo'),
('Bruno Costa', 'bruno@exemplo.com', 'Ativo'),
('Carla Dias', 'carla@exemplo.com', 'Pendente'),
('David Rocha', 'david@exemplo.com', 'Ativo'),
('Elena Souza', 'elena@exemplo.com', 'Inativo'),
('Felipe Lima', 'felipe@exemplo.com', 'Ativo'),
('Giovana Reis', 'giovana@exemplo.com', 'Pendente');



CREATE TABLE IF NOT EXISTS produtos (
    produto_id SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco NUMERIC(10, 2) NOT NULL,
    estoque INTEGER NOT NULL
);


INSERT INTO produtos (nome_produto, categoria, preco, estoque) VALUES
('Monitor 27 Polegadas', 'Eletrônicos', 1250.00, 15),
('Mouse Sem Fio', 'Acessórios', 89.90, 40),
('Teclado Mecânico', 'Acessórios', 350.00, 22),
('Livro Tecnico', 'Livros', 75.50, 100),
('Cadeira de Escritório', 'Móveis', 800.00, 8),
('Webcam HD', 'Eletrônicos', 150.00, 30),
('Fones Bluetooth', 'Acessórios', 450.00, 12);



CREATE TABLE IF NOT EXISTS pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_fk INTEGER REFERENCES clientes(cliente_id),
    data_pedido DATE NOT NULL,
    valor_total NUMERIC(10, 2) NOT NULL,
    metodo_pagamento VARCHAR(50)
);


INSERT INTO pedidos (cliente_fk, data_pedido, valor_total, metodo_pagamento) VALUES
(1, '2025-10-01', 1339.90, 'Cartão'),
(2, '2025-10-02', 800.00, 'Boleto'),
(3, '2025-10-03', 75.50, 'Pix'),
(4, '2025-10-04', 450.00, 'Cartão'),
(5, '2025-10-05', 150.00, 'Pix'),
(6, '2025-10-06', 350.00, 'Boleto'),
(7, '2025-10-07', 1250.00, 'Cartão');