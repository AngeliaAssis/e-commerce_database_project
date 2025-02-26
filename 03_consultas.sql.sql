-- iniciando exploração do banco de dados com queries de consulta
use `e-commerce`;

-- 1. Quais são os clientes cadastrados no banco de dados?
-- ✅ Objetivo: Listar todos os clientes com nome, sobrenome e CPF.

select FName, LName, CPF from clients;
select concat(FName, ' ', LName) as Complet_Name, CPF from clients;


-- 2. Quantos produtos existem no banco de dados e qual o valor médio dos produtos?
-- ✅ Objetivo: Contar quantos produtos existem e calcular o preço médio deles.

select count(*) idProduct from product;
select round(AVG(price), 2) from product;
-- or
select count(*) idProduct, round(AVG(price), 2) from product;
-- or
select count(idProduct) as contagem_produtos, round(AVG(price), 2) as media_preços from product;
	

-- 3. Quais pedidos foram feitos por um determinado cliente?
-- ✅ Objetivo: Listar os pedidos de um cliente específico pelo nome.

select idOrder from orders where idOrder_client = 2;
select idOrder, idClient, FName, LName from orders, clients where idOrder_client = idClient;

-- or
select idOrder, idClient, concat(FName, ' ', LName) as complet_name from orders, clients 
	where idOrder_client = idClient 
    order by idOrder;
    
-- or
select idOrder, Order_status, Order_description, concat(FName, ' ', LName) as complet_name from orders, clients 
	where idOrder_client = idClient 
    order by idOrder;
    
-- or
select idOrder, Order_status, Order_description, concat(FName, ' ', LName) as complet_name from orders, clients 
	where idOrder_client = idClient and FName = 'Maria' and LName = 'Oliveira'
    order by idOrder;
    
-- or
select idOrder, idOrder_client, Order_status, Order_description from orders 
	inner join clients 
    on orders.idOrder_client = clients.idClient;

-- or
select o.idOrder, o.idOrder_client, o.Order_status, o.Order_description, c.FName, c.LName from orders o 
	inner join clients c
    on o.idOrder_client = c.idClient;

-- or
select o.idOrder, o.Order_status, o.Order_description, c.FName, c.LName, p.product_name from orders o 
	inner join clients c
    on o.idOrder_client = c.idClient
    inner join product p
    on o.idOrder = p.idProduct;


-- 4. Quais produtos estão no estoque e qual o status de cada um?
-- ✅ Objetivo: Listar todos os produtos que estão no estoque e seu respectivo status.

select * from product_in_storage;

-- or
select * from product_in_storage ps
	inner join product p
    on ps.id_Sproduct = p.idProduct;
    
-- or
select ps.id_Sstorage, ps.in_storage_status, p.product_name, p.category from product_in_storage ps
	inner join product p
    on ps.id_Sproduct = p.idProduct;
    

-- 5. Qual é o produto mais caro e o mais barato disponível no banco de dados?
-- ✅ Objetivo: Identificar o produto mais caro e o mais barato com base no preço.

-- usando subqueries
select product_name, price from product 
where price = (select max(price) from product)
or price = (select min(price) from product);

-- usando order by
(select product_name, price from product
order by price ASC limit 1)
union
(select product_name, price from product
order by price DESC limit 1);


-- 6. Qual é o total gasto por cada cliente em pedidos?
-- ✅ Objetivo: Calcular quanto cada cliente gastou considerando a soma dos produtos comprados.

select * from product_order;
select * from product;

select c.FName, c.LName, o.idOrder, sum(p.price) as total_gasto
from clients c 
inner join orders o on c.idClient = o.idOrder_client
inner join product_order po on o.idOrder = po.id_Porder
inner join product p on po.id_Pproduct = p.idProduct
group by c.idClient, c.FName, c.LName, o.idOrder;


-- 7. Quais fornecedores fornecem quais produtos?
-- ✅ Objetivo: Listar o nome dos fornecedores e os produtos que cada um fornece.

select * from product_supplier;
select id_Psupplier, id_Pproduct, SocialName from product_supplier, supplier where id_Psupplier = idSupplier;

-- usando where
select id_Psupplier, id_Pproduct, SocialName, Product_name 
from product_supplier, supplier, product 
where id_Psupplier = idSupplier 
and id_Pproduct = idProduct;

-- usando join
select ps.id_Psupplier, ps.id_Pproduct, s.SocialName, p.Product_name 
from product_supplier ps
inner join supplier s on ps.id_Psupplier = s.idSupplier
inner join product p on ps.id_Pproduct = p.idProduct;


-- 8. Quais pedidos ainda estão pendentes?
-- ✅ Objetivo: Listar os pedidos que ainda não foram enviados ou entregues.

select * from orders;

select idOrder, order_status from orders where order_status <> 'Entregue';

select idOrder, order_status from orders where order_status <> 'Entregue' and order_status <> 'Enviado';


-- 9. Qual vendedor fornece quais produtos?
-- ✅ Objetivo: Listar os vendedores e os produtos que eles vendem.

select id_PSeller, SocialName, product_name from product_seller, seller, product
where id_PSeller = idSeller
and id_Pproduct = idProduct;


-- 10. Qual é a quantidade total de cada produto vendida até agora?
-- ✅ Objetivo: Somar a quantidade de cada produto que já foi vendido.

select * from product_order;

select po.id_Pproduct, sum(po.Quantity) as total_quantity, p.Product_name 
from product_order po
inner join product p on po.id_Pproduct = p.idProduct
group by po.id_Pproduct, p.Product_name;

-- 11. Quais clientes fizeram pedidos cujo total gasto foi maior que 500?
-- ✅ Objetivo: Selecionar os clientes que gastaram mais de 500 no somatório total dos pedidos.

select c.FName, c. LName, o.idOrder, sum(p.price) as total_gasto
from clients c
inner join orders o on c.idClient = o.idOrder_client
inner join product_order po on o.idOrder = po.id_Porder
inner join product p on po.id_Pproduct = p.idProduct
group by c.FName, c. LName, o.idOrder
having total_gasto > 500;