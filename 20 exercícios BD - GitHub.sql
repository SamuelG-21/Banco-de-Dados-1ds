create database if not exists db_loja;
use db_loja;
-- 2
create table if not exists tb_categoria
(
   cat_id int primary key auto_increment,
   cat_nome varchar(50) not null
);

-- 3
create table if not exists tb_fornecedor
(
   for_id int primary key auto_increment,
   for_nome varchar(60) not null,
   for_cidade varchar(50) not null
);

-- 4
create table if not exists tb_produto
(
   prod_id int primary key auto_increment,
   prod_nome varchar(80) not null,
   prod_data_cadastro date,
   prod_preco decimal(10,2),
   -- fk
   prod_id_categoria int not null,
   foreign key (prod_id_categoria) references tb_categoria(cat_id),
   
   prod_id_fornecedor int not null,
   foreign key (prod_id_fornecedor) references tb_fornecedor(for_id)
);

-- 5
insert into tb_categoria (cat_nome)
values
('Informática'),
('Eletrônicos'),
('Papelaria'),
('Games');

insert into tb_fornecedor (for_nome, for_cidade) values
('TechSul', 'Porto Alegre'),
('DistriMax', 'São Paulo'),
('Papel & Cia', 'Campinas'),
('GameHouse', 'São Paulo');

insert into tb_produto (prod_nome, prod_data_cadastro, prod_preco, prod_id_categoria, prod_id_fornecedor) values
('Mouse sem fio', '2024-02-10', 79.90, 1, 1),
('Teclado Mecânico', '2023-11-05', 249.00, 1, 2),
('Monitor 24 polegadas', '2023-08-14', 899.00, 2, 2),
('Fone Bluetooth', '2024-02-10', 159.90, 2, 2),
('Caixa de som portátil', '2022-12-01', 199.00, 2, 1),
('Carregador USB-C', '2024-03-18', 59.90 , 2, 1),
('Caderno 10 matérias', '2023-01-25', 32.50 , 3, 3),
('Caneta gel (kit 6)', '2024-01-08', 24.90 , 3, 3),
('Mochila escolar', '2023-07-30', 149.00, 3, 3),
('Controle sem fio', '2024-05-02', 349.90, 4, 4),
('Jogo de corrida', '2022-10-15', 199.90, 4, 4),
('Headset gamer', '2024-09-12', 289.00, 4, 2);

-- Parte B -> Consultas
-- 6
select prod_nome, prod_preco from tb_produto
where prod_id_fornecedor = 3;

-- 7
select * from tb_fornecedor
where for_cidade <> 'São Paulo';

-- 8
select prod_nome, prod_preco from tb_produto
where prod_preco > 200;

-- 9
select prod_nome, prod_preco from tb_produto
where prod_id_categoria = 2 and prod_preco < 100;

-- 10
select prod_nome, prod_id_categoria, prod_id_fornecedor from tb_produto
where prod_id_categoria = 1 or prod_id_fornecedor = 4;

-- 11
select prod_nome, prod_preco from tb_produto
where not prod_preco > 100; 

-- 12
select prod_id_categoria, prod_nome from tb_produto
where prod_id_categoria in (1,4);

-- 13
select * from tb_fornecedor
where for_cidade not in ('São Paulo','Campinas');

-- 14
select prod_preco AS Preco, prod_nome AS Produto
from tb_produto
where prod_preco between 50 and 200;

-- 15
select prod_nome, prod_data_cadastro from tb_produto
where prod_data_cadastro between '2024-01-01' and '2024-12-31';

-- 16
select prod_nome, prod_preco from tb_produto
where prod_preco not between 30 and 300;

-- 17
select prod_nome, prod_preco from tb_produto
where prod_id_categoria = (select cat_id from tb_categoria where cat_nome = 'Games');

-- 18
select P.prod_nome, P.prod_preco, C.cat_nome
from tb_produto P, tb_categoria C
where P.prod_id_categoria = C.cat_id;

-- 19
select P.prod_nome, C.cat_nome, F.for_nome
from tb_produto P, tb_categoria C, tb_fornecedor F 
where P.prod_id_categoria = C.cat_id and P.prod_id_fornecedor = F.for_id 
-- condição
and F.for_cidade like 'S%';

-- 20
SELECT COUNT(*) FROM tb_produto
where prod_id_fornecedor in (select for_id from tb_fornecedor where for_nome like 'DistriMax%');

-- Extras
-- 21
select distinct P.prod_nome as 'Produto' , C.cat_nome as 'Categoria'
from tb_produto P, tb_categoria C
where P.prod_id_categoria = C.cat_id;

-- 22
select P.prod_nome, P.prod_preco, F.for_nome, F.for_cidade
from tb_produto P, tb_fornecedor F
where P.prod_id_fornecedor = F.for_id
and F.for_cidade = 'São Paulo';

-- 23
select P.prod_nome, C.cat_nome, F.for_nome, P.prod_preco
from tb_produto P, tb_categoria C, tb_fornecedor F
where P.prod_id_categoria = C.cat_id and P.prod_id_fornecedor = F.for_id
and P.prod_preco > 200;

-- 24
select P.prod_nome, C.cat_nome, F.for_cidade
from tb_produto P, tb_categoria C, tb_fornecedor F
where P.prod_id_categoria = C.cat_id and P.prod_id_fornecedor = F.for_id
and (C.cat_nome = 'Informática' or C.cat_nome = 'Games');

-- 25
select count(P.prod_nome) as 'Prod <-> Quantidade' , C.cat_nome as 'Categoria'
from tb_produto P, tb_categoria C
where P.prod_id_categoria = C.cat_id
group by C.cat_nome;


-- 26
select F.for_nome , count(P.prod_nome)
from tb_produto P,  tb_fornecedor F
where P.prod_id_categoria = F.for_id
group by F.for_nome;

-- 27
select C.cat_nome , avg(P.prod_preco)
from tb_categoria C , tb_produto P
where P.prod_id_categoria = C.cat_id
group by C.cat_nome;

-- 28
select C.cat_nome, count(P.prod_nome)
from tb_produto P, tb_categoria C
where P.prod_id_categoria = C.cat_id
     and P.prod_preco > 100
group by C.cat_nome
having count(P.prod_nome) >= 2;


