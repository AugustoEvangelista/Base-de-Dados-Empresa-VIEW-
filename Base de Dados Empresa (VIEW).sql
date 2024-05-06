-- Criar banco de dados
CREATE DATABASE Loja;
USE Loja;

-- Criar tabela de Marcas
CREATE TABLE Marcas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL
);

-- Criar tabela de Fornecedores
CREATE TABLE Fornecedores (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL
);

-- Criar tabela de Produtos
CREATE TABLE Produtos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  marca_id INT,
  fornecedor_id INT,
  estoque INT NOT NULL,
  estoque_minimo INT,
  preco DECIMAL(10, 2),
  validade DATE,
  FOREIGN KEY (marca_id) REFERENCES Marcas(id),
  FOREIGN KEY (fornecedor_id) REFERENCES Fornecedores(id)
);
-- Inserir dados em Marcas
INSERT INTO Marcas (nome) VALUES ('Marca A'), ('Marca B'), ('Marca C');

-- Inserir dados em Fornecedores
INSERT INTO Fornecedores (nome) VALUES ('Fornecedor X'), ('Fornecedor Y'), ('Fornecedor Z');

-- Inserir dados em Produtos
INSERT INTO Produtos (nome, marca_id, fornecedor_id, estoque, estoque_minimo, preco, validade) 
VALUES 
('Produto 1', 1, 1, 100, 10, 20.00, '2025-12-31'),
('Produto 2', 2, 2, 50, 5, 30.00, '2023-12-31'),
('Produto 3', 3, 3, 5, 5, 40.00, '2023-06-30'),
('Produto 4', 1, 3, 200, 20, 25.00, '2026-01-31');

CREATE VIEW Produtos_Marcas AS
SELECT p.nome AS Produto, m.nome AS Marca
FROM Produtos p
JOIN Marcas m ON p.marca_id = m.id;

CREATE VIEW Produtos_Fornecedores AS
SELECT p.nome AS Produto, f.nome AS Fornecedor
FROM Produtos p
JOIN Fornecedores f ON p.fornecedor_id = f.id;

CREATE VIEW Produtos_Fornecedores_Marcas AS
SELECT p.nome AS Produto, m.nome AS Marca, f.nome AS Fornecedor
FROM Produtos p
JOIN Marcas m ON p.marca_id = m.id
JOIN Fornecedores f ON p.fornecedor_id = f.id;

CREATE VIEW Produtos_Estoque_Abaixo_Do_Minimo AS
SELECT p.nome AS Produto, p.estoque AS Estoque, p.estoque_minimo AS Estoque_Minimo
FROM Produtos p
WHERE p.estoque < p.estoque_minimo;

CREATE VIEW Produtos_Validade_Vencida AS
SELECT p.nome AS Produto, m.nome AS Marca, p.validade AS Validade
FROM Produtos p
JOIN Marcas m ON p.marca_id = m.id
WHERE p.validade < CURDATE();

CREATE VIEW Produtos_Preco_Acima_Da_Media AS
SELECT p.nome AS Produto, p.preco AS Preco
FROM Produtos p
WHERE p.preco > (SELECT AVG(preco) FROM Produtos);
