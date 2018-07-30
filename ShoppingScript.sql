-- Switch to the system (aka master) database
USE master;
GO

-- Delete the ShoppingEmp Database (IF EXISTS)
IF EXISTS(select * from sys.databases where name='ShoppingEmp')
DROP DATABASE ShoppingEmp;
GO

-- Create a new ShoppingEmp Database
CREATE DATABASE ShoppingEmp;
GO

-- Switch to the ShoppingEmp Database
USE ShoppingEmp
GO

Begin Transaction;

CREATE TABLE Category 
(
	id				integer				identity(1,1), 
	name			varchar(30),

	Constraint pk_category Primary Key (id)
);

CREATE TABLE Product
(
	id				integer				identity(1,1),
	name			varchar(max)		Not Null,
	description		varchar(max)		Not Null	default 'No description is available for this product',
	category_id		integer				Not Null,
	cost			money				Not Null,				
	image_name		varchar(45),

	Constraint pk_product Primary Key (id),
	Constraint fk_product_category Foreign Key (category_id) References Category (id)
);


CREATE TABLE Customer
(
	id				integer				identity(1,1), 
	username		varchar(45)			Not Null,
	email			varchar(100),
	password		varchar(25)			Not Null,

	Constraint pk_customer Primary Key (id)
);

CREATE TABLE Sale
(
	id				integer					identity(1,1), 
	product_id		integer					Not Null,
	dateofsale		datetime			Not Null	default Getdate(),
	quantity		integer				Not Null	default 1,

	Constraint pk_sale	Primary Key	(id),
	Constraint fk_sale_product	Foreign Key (product_id) references product (id)
);

CREATE TABLE Recent_Purchases 
(
	customer_id		integer					Not Null,
	sale_id			integer					Not Null,

	Constraint	pk_recent_purchases Primary Key (customer_id,sale_id),
	Constraint	fk_recent_purchases_customer	Foreign Key	(customer_id)	references Customer (id),	
	Constraint	fk_recent_purchases_sale	Foreign Key	(sale_id)	references Sale (id)	
);

Set identity_insert Category On;
Insert Into Category(id,name) Values (1,'Sport' );
Insert Into Category(id,name) Values (2,'Appliances' );
Insert Into Category(id,name) Values (3,'Grocery' );
Insert Into Category(id,name) Values (4,'Wine/Beer' );
Insert Into Category(id,name) Values (5,'Clothing' );
Insert Into Category(id,name) Values (6, 'Home');
Insert Into Category(id,name) Values (7,'Electronics');
Set identity_insert Category Off;

/*id, name, description, category_id, Is_BestSeller, cost, image_name */

Insert Into Product (name,category_id,cost,image_name) Values ('Spalding Basketball',1,23.99,'basketball.png');
Insert Into Product (name,category_id,cost,image_name) Values ('Assorted Skateboard Decks',1,34.99,'rainbow-skatedecks.png');
Insert Into Product (name,category_id,cost,image_name) Values ('Mr. Coffee Coffee Maker',2,19.99,'not-java.png');
Insert Into Product (name,category_id,cost,image_name) Values ('Hamilton Beach 2 Slice Toaster',2,16.99,'toaster.png');
Insert Into Product (name,category_id,cost,image_name) Values ('Perky Jerky Beef Jerky',3,5.99,'perky-jerky.png');
Insert Into Product (name,category_id,cost,image_name) Values ('Kicking Horse Coffee',3,8.99,'kicking-horse.png');
Insert Into Product (name,category_id,cost,image_name) Values ('Corona 12-Pack',4,15.00,'corona.png');
Insert Into Product (name,category_id,cost,image_name) Values ('Big Churn Chardonnay',4,6.99,'big-churn-wine.png');
Insert Into Product (name,category_id,cost,image_name) Values ('It Works On My Machine T-Shirt',5,5.99,'itworks-devshirt.png');
Insert Into Product (name,category_id,cost,image_name) Values ('Truly Funny T-Shirt',5,5.99,'truefunny-shirt.png');
Insert Into Product (name,category_id,cost,image_name) Values ('99 Bugs Developer Mug',6,12.99,'code-bugs-mugs.png');
Insert Into Product (name,category_id,cost,image_name) Values ('5ft Micro USB Cord',7,5.99,'micro-usb.png');
Insert Into Product (name,category_id,cost,image_name) Values ('5ft Mini USB Cord',7,5.99,'mini-usb.png');
Insert Into Product (name,category_id,cost,image_name) Values ('5ft Lightning USB Cord',7,9.99,'lightning-cable.png');
Insert Into Product (name,category_id,cost,image_name) Values ('5ft USB Type C Cord',7,5.99,'USB-type-c.png');

Commit Transaction;

-- Make Basketballs a best seller

--Count variable and product_ID variable
DECLARE @cnt INT = 0;
DECLARE @product INT = 1;
--Loop
WHILE @cnt < 101
BEGIN
Insert Into Sale (product_id, quantity)	Values (1, @cnt)			/*  DO SOMETHING */
   SET @cnt = @cnt + 1;
END;

--		  TRIGGER VS. MODEL
DECLARE @product INT = 1;

--Check total sales of item
Declare @totalSales INT; 
Set @totalSales=(select Count(sale.id) 
from Sale
Inner Join Product on Product.id=Sale.product_id 
where product_id= @product);


--Evaluate bool value to see if item is a top seller or not
Declare @bool bit;
set @bool= Case when (@totalSales > 100) then 1 else 0 end;

Print @bool;


DECLARE @product INT = 1;
Declare @totalSales INT; 
            Set @totalSales = (select Count(sale.id)
            from Sale
            Inner Join Product on Product.id = Sale.product_id
            where product_id = @product);
            Declare @bool bit;
            set @bool = Case when(@totalSales > 100) then 1 else 0 end;
            Print @bool;



-- set value
Update Product 
Set Is_BestSeller = @bool 
Where Product.id=@product;

--		sql while loop

--DECLARE @cnt INT = 0;

--WHILE @cnt < 102
--BEGIN
--Insert Into Sale (product_id, quantity)	Values (1, @cnt)			/*  DO SOMETHING */
--   SET @cnt = @cnt + 1;
--END;


-- Make Big Churn a best seller
Set @product=8;


Set @cnt = 0;

WHILE @cnt < 150
BEGIN
Insert Into Sale (product_id, quantity)	Values (@product, 6)			/*  DO SOMETHING */
   SET @cnt = @cnt + 1;
END;


--Declare @totalSales INT; 
Set @totalSales=(select Count(sale.id) 
from Sale
Inner Join Product on Product.id=Sale.product_id 
where product_id=@product);

--Declare @bool bit;
set @bool= Case when (@totalSales > 100) then 1 else 0 end;
Update Product 
Set Is_BestSeller = @bool 
Where Product.id=@product;

-- Give all USBs and shirts 2 less than best seller status 


Set @cnt = 0;

WHILE @cnt < 98
BEGIN
Insert Into Sale (product_id, quantity)	Values (9, 6)			
Insert Into Sale (product_id, quantity)	Values (10, 6)			
Insert Into Sale (product_id, quantity)	Values (12, 6)			
Insert Into Sale (product_id, quantity)	Values (13, 6)			
Insert Into Sale (product_id, quantity)	Values (14, 6)			
Insert Into Sale (product_id, quantity)	Values (15, 6)			
   SET @cnt = @cnt + 1;
END;


--Declare @totalSales INT; 
Set @totalSales=(Select Count(sale.id) 
From Sale
Inner Join Product On Product.id=Sale.product_id 
Where product_id = 9);

--Declare @bool bit;
set @bool= Case When (@totalSales > 100) Then 1 Else 0 End;
Update Product 
Set Is_BestSeller = @bool 
Where Product.id In (9,10,12,13,14,15);

Select Count(*) From Sale
Where product_id = 13