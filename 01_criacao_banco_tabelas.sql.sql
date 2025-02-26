-- criação do banco de dados "e-commerce"
-- create database "e-commerce";

show databases;
use `e-commerce`;

-- criação da tabela cliente

create table Clients(
	idClient int not null auto_increment primary key,
    FName varchar(20),
    LName varchar(20),
    CPF char(11) not null unique,
    Address varchar(200),
    Birth_date date not null
);

-- criação da tabela produto

create table Product(
	idProduct int not null auto_increment primary key,
    Product_name varchar(45) not null,
    Product_description varchar(200),
    Category enum("Eletronic", "Dressing", "Furniture", "House") not null,
    Color varchar(10),
    Size varchar(10),
    Price float not null,
    Feedback float default 0
);

-- criação da tabela pedido

create table Orders(
	idOrder int not null auto_increment primary key,
    idOrder_client int,
    Order_status enum("Em andamento", "Processando", "Enviado", "Entregue") not null default "Processando",
    Order_description varchar(200),
    Delivery_price float,
    constraint fk_orders_client foreign key (idOrder_client) references Clients(idClient)
);

-- criação da tabela estoque

create table ProductStorage(
	idStorage int not null primary key,
    Storage_location varchar(200)
);

-- criação da tabela fornecedor

create table Supplier(
	idSupplier int not null primary key,
    SocialName varchar(45) not null,
    Address varchar(200),
    Contact char(11) not null,
    CNPJ char(14) not null unique
);

-- criação da tabela vendedor

create table Seller(
	idSeller int not null primary key,
    SocialName varchar(45) not null,
    Address varchar(200),
    Contact char(11) not null,
    CNPJ char(14) not null unique
);

-- criação da tabela relacionamento produto/vendedor

create table Product_Seller(
	id_Pseller int,
    id_Pproduct int,
    primary key (id_Pseller, id_Pproduct),
    constraint fk_productseller_seller foreign key (id_Pseller) references Seller(idSeller),
    constraint fk_productseller_product foreign key (id_Pproduct) references Product(idProduct)
);

-- criação da tabela relacionamento produto/estoque

create table Product_in_storage(
	id_Sstorage int,
    id_Sproduct int,
    in_storage_status enum("Em estoque", "Estoque indisponível") not null,
    primary key (id_Sstorage, id_Sproduct),
    constraint fk_instorage_ProductStorage foreign key (id_Sstorage) references ProductStorage(idStorage),
    constraint fk_instorage_product foreign key (id_Sproduct) references Product(idProduct)
);


-- criação da tabela relacionamento produto/fornecedor

create table Product_Supplier(
	id_Psupplier int,
    id_Pproduct int,
    primary key (id_Psupplier, id_Pproduct),
    constraint fk_productsupplier_supplier foreign key (id_Psupplier) references Supplier(idSupplier),
    constraint fk_productsupplier_product foreign key (id_Pproduct) references Product(idProduct)
);


-- criação da tabela relacionamento produto/pedido

create table Product_Order(
	id_Porder int,
    id_Pproduct int,
    Quantity int default 1,
    Product_order_status enum("disponível", "indisponível") default "disponível",
    primary key (id_Porder, id_Pproduct),
    constraint fk_productorder_orders foreign key (id_Porder) references Orders(idOrder),
    constraint fk_productorder_product foreign key (id_Pproduct) references Product(idProduct)
);

-- checando as tabelas criadas
desc clients;
desc orders;
desc product;
desc product_supplier;
desc product_seller;
desc product_order;
desc product_in_storage;
desc productStorage;
desc seller;
desc supplier;

-- checando as constraints
show databases;
use information_schema;
show tables;
desc table_constraints;
desc referential_constraints;
select * from referential_constraints;
select * from referential_constraints where constraint_schema = "e-commerce";