-- CTE : Common Table Expressions
DECLARE @produit1 INT =44;


WITH 
-- Clients ayant acheté le produit 44 en 2006
CustAchat44En2006 AS (
				SELECT DISTINCT custid
				FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
				WHERE productid=@produit1 AND YEAR(O.orderdate)=2006
),
-- Clients ayant acheté le produit 46 en 2007
CustAchat46EN2007 AS (
				SELECT DISTINCT custid
				FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
				WHERE productid=46 AND YEAR(O.orderdate)=2007
)
SELECT * FROM [Sales].[Customers]
WHERE custid IN (SELECT * FROM CustAchat44En2006)
AND custid NOT IN (SELECT * FROM CustAchat46EN2007)

-- CTE : Common Table Expressions
;WITH 
-- Clients ayant acheté le produit 44 en 2006
CustAchat44En2006 AS (
				SELECT DISTINCT custid
				FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
				WHERE productid=44 AND YEAR(O.orderdate)=2006
),
-- Clients ayant acheté le produit 46 en 2007
CustAchat46EN2007 AS (
				SELECT DISTINCT custid
				FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
				WHERE productid=46 AND YEAR(O.orderdate)=2007
),
CustRecherches AS (
			SELECT * FROM CustAchat44En2006
			EXCEPT
				-- custid ayant achete le produit 46 en 2007
			SELECT * FROM CustAchat46EN2007
)
SELECT * FROM [Sales].[Customers] AS C
INNER JOIN CustRecherches AS CID
ON CID.custid=C.custid
