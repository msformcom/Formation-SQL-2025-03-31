-- Ventes sans infos clients
SELECT * FROM [Sales].[Orders]
WHERE custid IS NULL
 ORDER BY custid
-- Mise à jour des données
UPDATE [Sales].[Orders]
SET custid = NULL
WHERE Custid=2

-- Les commandes seulement avec client associés
SELECT O.orderdate AS DateCommande,
		C.companyname AS Compagnie
FROM [Sales].[Orders] AS O INNER JOIN [Sales].[Customers] AS C
ON O.custid=C.custid

-- Toutes les commandes même sans client
SELECT O.orderdate AS DateCommande,
		C.companyname AS Compagnie
FROM [Sales].[Orders] AS O LEFT JOIN [Sales].[Customers] AS C
ON O.custid=C.custid

-- Tous les clients même ceux sans commande
SELECT O.orderdate AS DateCommande,
		C.companyname AS Compagnie
FROM [Sales].[Orders] AS O RIGHT JOIN [Sales].[Customers] AS C
ON O.custid=C.custid

-- Toutes les commandes même sans client
-- Tous les clients même ceux sans commande associée
SELECT O.orderdate AS DateCommande,
		C.companyname AS Compagnie
FROM [Sales].[Orders] AS O FULL  JOIN [Sales].[Customers] AS C
ON O.custid=C.custid



