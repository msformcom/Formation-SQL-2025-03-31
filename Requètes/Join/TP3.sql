/*
Ventes des produit
| Date vente | Quantite vendue | Id produit | ProductName
Pour tous les produits (même ceux non vendus)
*/

SELECT * FROM Sales.OrderDetails
-- Je m'assure que le produit 72 n'est pas dans les lignes de commande
-- en remplaçant sa référence par le produit 49
UPDATE Sales.OrderDetails
SET productid=49 
WHERE productid=72


SELECT O.orderdate AS DateCommande,
		OD.qty AS Quantite,
		-- Je prend le productid dans la tables des produits car 
		-- dans la table des ventes il n'est pas toujours présent
		-- dans le cas où pas de vente
		P.productid AS IdProduit,
		P.productname AS NomProduit
FROM [Sales].[Orders] AS O
INNER JOIN [Sales].[OrderDetails] AS OD 
ON O.orderid=OD.orderid
RIGHT JOIN [Production].[Products] AS P
ON OD.productid=P.productid
ORDER BY OD.productid