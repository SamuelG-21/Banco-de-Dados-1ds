
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


