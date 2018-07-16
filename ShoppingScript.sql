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

CREATE TABLE Product
(

);

CREATE TABLE Category 
(

);

CREATE TABLE User
(

);

CREATE TABLE Sale
(

);

CREATE TABLE Recent_Purchases 
(

);

Commit Transaction;