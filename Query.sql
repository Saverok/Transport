Use master;
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'Shop')
BEGIN
	DROP DATABASE Shop
END;
GO

CREATE DATABASE Shop;
GO

USE Shop;
GO

IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'Orders' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.Orders;
GO

IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'Customers' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers
(
	Id INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(20) NOT NULL,
	PRIMARY KEY(Id)
) 
GO

INSERT INTO dbo.Customers(Name)
VALUES ('Max'), ('Pavel'), ('Ivan'), ('Leonid');
GO

CREATE TABLE dbo.Orders
(
	Id INT IDENTITY(1,1) NOT NULL,
	CustomerId INT NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_CustomerId FOREIGN KEY (CustomerId)
	REFERENCES dbo.Customers(Id) 
);
GO 

INSERT INTO dbo.Orders(CustomerId)
VALUES (2), (4);
GO

SELECT cst.Name AS Customers
FROM dbo.Orders AS ord
RIGHT JOIN dbo.Customers as cst ON cst.Id = ord.CustomerId
WHERE ord.Id  IS NULL;
GO