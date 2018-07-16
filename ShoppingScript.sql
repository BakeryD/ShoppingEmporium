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
	id				integer					identity(1,1), 
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

	Constraint pk_product Primary Key (id),
	Constraint fk_product_category Foreign Key (category_id) References Category (id)
);


CREATE TABLE Customer
(
	id int identity(1,1), 
	
);

CREATE TABLE Sale
(
	id int identity(1,1), 
	
);

CREATE TABLE Recent_Purchases 
(

);

Commit Transaction;