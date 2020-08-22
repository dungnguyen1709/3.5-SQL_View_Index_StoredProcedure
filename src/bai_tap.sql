use bai_tap_view_index_store_procedure;

create table products(
                         id int,
                         productCode varchar(15),
                         productName varchar(15),
                         productPrice float,
                         productAmount int,
                         productDescription varchar(30),
                         productStatus bit
);

insert into products
values (1,'D1','KeoMut',5000,16,'ChupBaChip',1),
       (2,'D2','BimBim',6000,6,'Oshi',0),
       (3,'D3','KeoDua',15000,3,'BenTre',1),
       (4,'D4','ThachRauCau',30000,7,'LongHai',0),
       (5,'D5','SuaTuoi',8000,9,'Vinamilk',1);

alter table products add unique index index_code (productCode);

explain select * from products where productCode = 'D2';

alter table products add unique composite_index (productName,productPrice);

explain select * from products where productName = 'BimBim' and productPrice = 6000;

drop index composite_index on products;

create view products_view as
select productCode,productName,productPrice,productStatus
from products;

select * from products_view;

insert into products (productDescription)
values ('KeoMut');

select * from products;

drop view products_view;

drop table products;



delimiter //
create procedure findAllProducts()
begin
    select * from products;
end //

call findAllProducts();

delimiter //
create procedure addProducts()
begin
    insert into products
    values (6,'D6','Kem',30000,3,'TrangTien',1);
end //

call addProducts();

select * from products;

delimiter //
create procedure editProducts(in id1 int,
                              in productCode1 varchar(15),
                              in productName1 varchar(15),
                              in productPrice1 float,
                              in productAmount1 int,
                              in productDescription1 varchar(30),
                              in productStatus1 bit )
begin
    update products
    set productCode = productCode1,
        productName = productName1,
        productPrice = productPrice1,
        productAmount = productAmount1,
        productDescription = productDescription1,
        productStatus = productStatus1
    where id = id1;
end //

call editProducts(5,'D5',
                  'BanhMy',
                  35000,
                  4,
                  'KinhDo',
                  0);

select * from products;

delimiter //
create procedure removeProducts(in id1 int)
begin
    delete from products
    where id = id1;
end //

call removeProducts(6);

select * from products;


