-- acessando o banco de dados
use `e-commerce`;

-- verificando as tabelas criadas
show tables;

-- alimentando o BD com dados

-- inserindo e conferindo dados na tabela clients
desc clients;

insert into clients (FName, LName, CPF, Address, Birth_date) values
('João', 'Silva', '12345678901', 'Rua A, 123, Jd. das Rosas, Cuiabá, Mato Grosso', '1990-05-10'),
('Maria', 'Oliveira', '98765432100', 'Avenida B, 456, bairro das Camélias, Acaraju, Sergipe', '1985-07-22'),
('Carlos', 'Pereira', '45612378922', 'Travessa C, 789, Vila das Orquídeas, Brasília, DF', '2000-01-30'),
('Aurélia', 'Martins', '32156987258', 'Rua C, 102, bairro Jardim, Campinas, São Paulo', '2010-07-18');

select * from clients;

-- inserindo e conferindo dados na tabela product

desc product;

insert into product (Product_name, Product_description, Category, Price, Color, Size, Feedback) values
	('Notebook Dell', 'Inspiron 15, 8GB RAM, SSD 512GB', 'Eletronic', 4500.00, 'Preto', '15 pol', 4.7),
	('Smartphone Samsung', 'Galaxy S22, 128GB', 'Eletronic', 3500.00, 'Azul', '6.2 pol', 4.5),
	('Smart TV LG', '4K UHD, 50 polegadas', 'Eletronic', 3200.00, 'Preto', '50 pol', 4.8),
    ('Camiseta preta', 'tecido algodão e poliéster', 'Dressing', 40.00, 'Preto', 'M', 4.0),
    ('Camiseta branca', 'tecido algodão e poliéster', 'Dressing', 35.00, 'Branco', 'G', 4.3),
    ('Sofá Show 3 lugares', 'tecido suede, espuma 30 cm', 'Furniture', 2500.00, 'Marrom', '2 metros', 3.7),
    ('Quadro decorativo NY', 'paisagem NY city a noite', 'House', 700.00, 'Colorido', '1.00x1.50', 3.5);
    
select * from product;

-- inserindo e conferindo dados na tabela orders

desc orders;

insert into orders (idOrder_client, Order_status, Order_description, Delivery_price) values
	(1, 'Enviado', 'Enviado pelos correios', 25.50),
	(2, 'Enviado', 'Enviado por motoboy', 15.00),
    (2, 'Entregue', 'Recebido pela irmã', 15.00),
    (4, 'Processando', 'Aguardando compensação', 10.00),
    (3, 'Em andamento', 'Separando os itens', 7.00),
    (4, 'Entregue', 'Recebido pelo próprio', 15.00);
    
select * from orders;

-- inserindo e conferindo dados na tabela productstorage

desc productstorage;

insert into productstorage (idStorage, Storage_location) values
	(101, 'Galpão Central, MG'),
	(102, 'Filial Norte, AM'),
    (103, 'Filial Sul, SC');
    
select * from productstorage;

-- inserindo e conferindo dados na tabela supplier

desc supplier;

insert into supplier (idSupplier, SocialName, Address, Contact, CNPJ) values
	(201, 'Distribuidora Alpha', 'Rua Central, 321, Santa Maria, RS', 1785569617, 12123123000155),
	(202, 'Suprimentos Beta', 'Avenida Sul, 654, Novo Horizonte, SP', 1176591981, 78789456000133);
    
select * from supplier;

-- inserindo e conferindo dados na tabela seller

desc seller;

insert into seller (idSeller, SocialName, Address, CNPJ, Contact) values
	(301, 'Tech Solutions', 'Rua XPTO, 999', '12345678000199', '11999999999'),
	(302, 'EletroMax', 'Avenida YZ, 432', '98765432000188', '11888888888'),
	(303, 'Móveis Finos', 'Avenida Zero, 181', '55612236000177', '11666666666'),
    (304, 'Roupas Feliz', 'Rua da Sorte, 444', '36951159000144', '117777777');
    
select * from seller;
    
-- inserindo e conferindo dados na tabela Product_Seller

desc Product_Seller;

insert into Product_Seller values 
	(301, 1),
    (301, 2),
    (302, 3),
    (303, 6),
    (303, 7),
    (304, 4),
    (304, 5);
    
select * from Product_Seller;

-- inserindo e conferindo dados na tabela Product_in_storage

desc Product_in_storage;

insert into Product_in_storage (id_Sstorage, id_Sproduct, in_storage_status) values
	(101, 1, 'Em estoque'),
    (102, 2, 'Em estoque'),
    (103, 3, 'Estoque indisponível'),
    (102, 4, 'Em estoque'),
    (102, 3, 'Estoque indisponível'),
    (102, 5, 'Estoque indisponível'),
    (103, 6, 'Em estoque'),
	(101, 7, 'Em estoque');
    
select * from Product_in_storage;

-- inserindo e conferindo dados na tabela Product_supplier

desc product_supplier;

insert into product_supplier (id_Psupplier, id_Pproduct) values
	(201, 1),
	(201, 2),
	(201, 3),
    (201, 7),
	(202, 4),
	(202, 5),
	(202, 6),
	(202, 7),
    (202, 1);
    
select * from product_supplier;

-- inserindo e conferindo dados na tabela product_order

desc product_order;

insert into product_order values 
	(1, 2, 1, default),
	(2, 5, 5, 'disponível'),
	(3, 1, 1, 'disponível'),
	(4, 7, 1, default),
	(3, 4, 3, 'indisponível'),
	(4, 6, 1, 'disponível'),
	(4, 3, 2, 'indisponível');

select * from product_order;

