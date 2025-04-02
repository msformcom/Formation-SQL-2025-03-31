/*
	le produit 44 utilise comme consommable le produit 46
	Connaitre les clients qui ont achete le produit 44 en 2006 mais qui n'ont pas achete le produit 46
		en 2007



*/

-- custid ayant achete le produit 45 en 2006
SELECT * FROM [Sales].[Customers] AS C
INNER JOIN (
				-- Id des customers ayant achete le produit 44 en 2006
				SELECT DISTINCT custid
				FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
				WHERE productid=44 AND YEAR(O.orderdate)=2006
			EXCEPT
				-- custid ayant achete le produit 46 en 2007
				SELECT DISTINCT custid
				FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
				WHERE productid=46 AND YEAR(O.orderdate)=2007
			) AS CID
ON CID.custid=C.custid


SELECT * FROM [Sales].[Customers]
WHERE custid IN (
				-- Id des customers ayant achete le produit 44 en 2006
				SELECT DISTINCT custid
				FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
				WHERE productid=44 AND YEAR(O.orderdate)=2006
	)
AND custid NOT IN (
				-- custid ayant achete le produit 46 en 2007
				SELECT DISTINCT custid
				FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
				WHERE productid=46 AND YEAR(O.orderdate)=2007
)

SELECT * FROM [Sales].[Customers] AS C
WHERE EXISTS(
		SELECT *
		FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
		WHERE productid=44 AND YEAR(O.orderdate)=2006 AND custid=C.custid
)
AND NOT EXISTS(
		SELECT *
		FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
		WHERE productid=46 AND YEAR(O.orderdate)=2007 AND custid=C.custid
)