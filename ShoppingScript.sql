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
	name			varchar(30)			Not Null,
	description		varchar(max)		Not Null	default 'No description is available for this product',
	category_id		integer				Not Null,
	Is_BestSeller	bit,
	cost			money,				
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

Insert Into Category Values ('Sport' );
Insert Into Category Values ('Appliances' );
Insert Into Category Values ('Grocery' );
Insert Into Category Values ('Wine/Beer' );
Insert Into Category Values ('Clothing' );

Commit Transaction;