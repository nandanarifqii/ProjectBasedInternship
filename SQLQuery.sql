CREATE DATABASE DWH_Project;

CREATE TABLE DimCustomer (
	CustomerID int NOT NULL,
	CustomerName varchar (50) NOT NULL,
	Age int NOT NULL,
	Gender varchar (50) NOT NULL,
	City varchar (50) NOT NULL,
	NoHp varchar (50) NOT NULL,
	CONSTRAINT PK_DimCustomer PRIMARY KEY (CustomerID)
)

CREATE TABLE DimProduct (
	ProductID int NOT NULL,
	ProductName varchar (255) NOT NULL,
	ProductCategory varchar (255) NOT NULL,
	ProductUnitPrice int NOT NULL,
	CONSTRAINT PK_DimProduct PRIMARY KEY (ProductID)
)

CREATE TABLE DimStatusOrder (
	StatusID int NOT NULL,
	StatusOrder varchar (50) NOT NULL,
	StatusOrderDesc varchar (50) NOT NULL,
	CONSTRAINT PK_DimStatusOrder PRIMARY KEY (StatusID)
)

CREATE TABLE FactSalesOrder (
	OrderID int NOT NULL,
	CustomerID int NOT NULL,
	ProductID int NOT NULL,
	StatusID int NOT NULL,
	Quantity int NOT NULL,
	Amount int NOT NULL,
	OrderDate date NOT NULL,
	CONSTRAINT PK_FactSalesOrder PRIMARY KEY (OrderID),
	CONSTRAINT FK_FactSalesOrderC FOREIGN KEY (CustomerID) REFERENCES DimCustomer (CustomerID),
	CONSTRAINT FK_FactSalesOrderP FOREIGN KEY (ProductID) REFERENCES DimProduct (ProductID),
	CONSTRAINT FK_FactSalesOrderS FOREIGN KEY (StatusID) REFERENCES DimStatusOrder (StatusID)
);

SELECT * FROM DimCustomer;
SELECT * FROM DimProduct;
SELECT * FROM DimStatusOrder;
SELECT * FROM FactSalesOrder;

DELETE FROM DimCustomer;
DELETE FROM DimProduct;
DELETE FROM DimStatusOrder;
DELETE FROM FactSalesOrder;



CREATE PROCEDURE summary_order_status
(@StatusID int) AS
BEGIN
	SELECT
		f.OrderID,
		c.CustomerName,
		p.ProductName,
		f.Quantity,
		s.StatusOrder
	FROM FactSalesOrder AS f
	JOIN DimCustomer c ON f.CustomerID = c.CustomerID
	JOIN DimProduct p ON f.ProductID = p.ProductID
	JOIN DimStatusOrder s ON f.StatusID = s.StatusID
	WHERE s.StatusID = @StatusID
END

EXEC summary_order_status @StatusID = 4