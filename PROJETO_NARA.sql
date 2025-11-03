CREATE DATABASE PROJETO_NARA;

USE PROJETO_NARA;

CREATE TABLE produtos (id INT PRIMARY KEY AUTO_INCREMENT,
Nome_Produto VARCHAR(100), 
Categoria VARCHAR(20), 
Preco DECIMAL(10,2), 
Marca VARCHAR(50));

CREATE TABLE clientes (id INT PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(100), 
Idade INT, 
Sexo VARCHAR(20), 
Cidade VARCHAR(100), 
estado VARCHAR(2), 
Canal_Aquisicao VARCHAR(100));

CREATE TABLE vendas ( id INT PRIMARY KEY, 
Data_venda DATE, 
Quantidade INT, 
ID_Cliente INT,
FOREIGN KEY (ID_Cliente) REFERENCES clientes(id), 
ID_Produto INT, 
FOREIGN KEY (ID_Produto) REFERENCES produtos(id), 
Canal VARCHAR(100), 
Valor_Total DECIMAL(10,2));

CREATE TABLE atendimentos ( id INT PRIMARY KEY, 
ID_Cliente INT,
FOREIGN KEY (ID_Cliente) REFERENCES clientes(id),  
Tipo VARCHAR(100), 
Data_Atendimento DATE, 
Tempo_Resposta DECIMAL(10,2), 
Nota_Satisfacao INT);

CREATE TABLE campanhas (id INT PRIMARY KEY AUTO_INCREMENT,
Canal VARCHAR(100), 
Data_Inicio DATE, 
Data_Fim DATE, 
Tipo_Campanha VARCHAR(100),
Custo DECIMAL(10,2));

CREATE TABLE avaliacoes ( id INT PRIMARY KEY,  
ID_Cliente INT,
FOREIGN KEY (ID_Cliente) REFERENCES clientes(id), 
ID_Produto INT, 
FOREIGN KEY (ID_Produto) REFERENCES produtos(id), 
Nota INT, 
Data_Avaliacao DATE, 
Comentario VARCHAR(100));

SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'C:/Users/leticya.franca/Downloads/clientes.csv'
INTO TABLE clientes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nome, Idade, sexo, Cidade, Estado, Canal_Aquisicao);

LOAD DATA INFILE 'C:/Users/leticya.franca/Downloads/produtos.csv'
INTO TABLE produtos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nome_Produto, Categoria, Preco, Marca);

LOAD DATA INFILE 'C:\Users\leticya.franca\Downloads\vendas.csv'
INTO TABLE vendas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/leticya.franca/Downloads/venda 1.csv'
INTO TABLE vendas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/leticya.franca/Downloads/venda 2.csv'
INTO TABLE vendas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/leticya.franca/Downloads/venda 3.csv'
INTO TABLE vendas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/leticya.franca/Downloads/atendimentos.csv'
INTO TABLE atendimentos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/leticya.franca/Downloads/campanhas_corrigido.csv'
INTO TABLE campanhas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/leticya.franca/Downloads/avaliacoes.csv'
INTO TABLE avaliacoes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# Padroes de compra por perfil de cliente 

SELECT clientes.Sexo, clientes.Idade, clientes.Cidade, vendas.Canal,
		COUNT(vendas.id) AS Total_Vendas,
        SUM(vendas.Valor_Total) AS Valor_Total_Compras
        FROM vendas
        JOIN clientes ON vendas.ID_Cliente = clientes.id
        GROUP BY clientes.Sexo, clientes.Idade, cliemtes.Cidade, vendas.Canal
        ORDER BY Valor_Total_Compras DESC;
        
# Produtos com desempenho abaixo do esperado

SELECT produtos.Nome_Produto, produtos.Categoria, 
		AVG(avaliacoes.Nota) AS Media_Nota,
		COUNT(avaliacoes.id) AS Quantidade_Avaliacoes
        FROM avaliacoes
        JOIN produtos ON avaliacoes.ID_Produto = produtos.id
        GROUP BY produtos.Nome_Produto, produtos.Categoria
        ORDER BY Media_Nota ASC;
        
# Impacto das campanhas de marketing nas vendas

SELECT vendas.Canal,
		COUNT(vendas.id) AS Total_Vendas,
        SUM(vendas.Valor_Total) AS Valor_Total,
        COUNT(DISTINCT campanhas.id) AS Total_Campanhas
        FROM vendas
        JOIN campanhas ON vendas.Canal = campanhas.Canal
        GROUP BY vendas.Canal
        ORDER BY Valor_Total DESC;
        
# Eficiencia dos atendimentos e satisfaçao

SELECT AVG(atendimentos.Tempo_Resposta) AS Tempo_Medio_Resposta,
		AVG(atendimentos.Nota_Satisfacao) AS Media_Satisfacao
        FROM atendimentos
        GROUP BY atendimentos.Tipo
        ORDER BY Media_Satisfacao DESC;
        
# Evolução dos resultados

Select YEAR(vendas.Data_venda) AS Ano, 
		MONTH(vendas.Data_venda) AS Mes,
        SUM(vendas.Valor_Total) AS Total_Vendas
        FROM vendas
        GROUP BY Ano, Mes
        ORDER BY Ano, Mes;


# Correlações entre variáveis (preço, nota, tempo de resposta e valor de venda.)
        
SELECT produtos.Nome_Produto, produtos.Preco,
		AVG(avaliacoes.Nota) AS Media_Nota, 
        SUM(vendas.Valor_Total) AS Total_Vendas
        FROM produtos
        LEFT JOIN avaliacoes ON produtos.id = avaliacoes.ID_Produto
        LEFT JOIN vendas ON produtos.id = vendas.ID_Produto
        GROUP BY produtos.Nome_produto, produtos.Preco
        ORDER BY Total_Vendas DESC; 

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        






