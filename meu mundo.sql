
create database mundo;
use mundo;

CREATE TABLE pais (
    id_pais INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(35) NOT NULL,
    continente VARCHAR(35),
    pop REAL,
    PIB REAL,
    Expec_vida REAL
);

CREATE TABLE cidade (
    id_cidade INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(35),
    pais VARCHAR(35),
    Pop REAL,
    capital ENUM ('Sim', 'Não'),
    id_pais INT,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE Rio (
    id_rio INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(35),
    Origem VARCHAR(35),
    Comprimento INTEGER
);

CREATE TABLE cidade_rio 
(
    id_cidade INT,
    id_rio INT,
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade),
    FOREIGN KEY (id_rio) REFERENCES Rio(id_rio)
);


insert into pais (Nome, continente, pop, PIB, Expec_vida) VALUES 
('Canada', 'Am.Norte', 30.1, 658, 77.08),
('Mexico', 'Am.Norte', 107.5, 694, 69.1),
('Brasil', 'Am.Sul', 183.3, 10004, 65.2),
('USA', 'Am.Norte', 270.0, 8003, 75.5);


insert into cidade (Nome, pais, Pop, capital, id_pais) VALUES 
('Washington', 'USA', 3.3, 'Sim', 4),
('Monterrey', 'Mexico', 2.0, 'Não', 2),
('Brasilia', 'Brasil', 1.5, 'Sim', 3),
('São Paulo', 'Brasil', 15.0, 'Não', 3),
('Ottawa', 'Canada', 0.8, 'Sim', 1),
('Cid.Mexico', 'Mexico', 14.1, 'Sim', 2);

insert into Rio (Nome, Origem, Comprimento) VALUES 
('St.Lawrence', 'USA', 3050),
('Grande', 'USA', 3034),
('Parana', 'Brasil', 4880),
('Mississipi', 'USA', 3730);

-- Ex 1
SELECT cidade.nome , pais.nome
from cidade
inner join pais
on cidade.id_pais = pais.id_pais;

-- Ex 2
select Nome from cidade
where capital = 'Sim'; 

-- Ex 3
select * from pais
where Expec_vida < 70;

-- Ex 4
select cidade.Nome, pais.Nome , pais.pop
from cidade
inner join pais on cidade.id_pais = pais.id_pais
where cidade.capital = 'Sim'
and pais.PIB > 1000;

-- Ex 5
select cidade.Nome, cidade.Pop
from cidade
inner join pais on cidade.id_pais = pais.id_pais
inner join cidade_rio on cidade.id_cidade = cidade_rio.id_cidade --conectamos cidades aos rios que passam por elas.
inner join rio on cidade_rio.id_rio = rio.id_rio --  trazemos os dados dos rios.
where rio.Nome = 'St.Lawrence'
    and capital = 'Sim';

-- Ex 6
SELECT AVG(Pop) -- AVG é a função de agregação para calcular a média da população
FROM cidade
WHERE capital = 'Não';

-- Ex 7
select AVG(PIB), continente from pais
group by continente -- o SQL vai calcular a média do PIB agrupando os países por continente.

-- Ex 8
SELECT pais.Nome, MIN(rio.Comprimento)
FROM pais
INNER JOIN cidade ON pais.id_pais = cidade.id_pais
INNER JOIN cidade_rio ON cidade.id_cidade = cidade_rio.id_cidade
INNER JOIN rio ON cidade_rio.id_rio = rio.id_rio
GROUP BY pais.Nome
HAVING COUNT(rio.id_rio) >= 2;

-- Ex 9
SELECT Nome, PIB
FROM pais
WHERE PIB > (
    SELECT PIB
    FROM pais
    WHERE Nome = 'Canada'
);
