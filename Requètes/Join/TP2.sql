/*
Liste des ventes de produit
| Date commande | Prix vente | Nom produit | Prix produit
| Orders => OrderDetails => Products
| Products => OrderDetails => Orders
| OrderDetails => Products => Orders Eviter
condition : Prix vente < 75% du prix produit
ordre : reduction % decroissante

*/

SELECT O.orderdate AS DateCommande,
		OD.unitprice AS PrixVente,
		P.productname AS NomProduit,
		P.unitprice AS PrixProduit,
		OD.unitprice/ P.unitprice AS ReductionPercent
FROM [Sales].[Orders] AS O
-- Jointure Orders => OrderDetails 
INNER JOIN [Sales].[OrderDetails] AS OD
ON O.orderid=OD.orderid
-- Jointure OrderDetails => Products
INNER JOIN [Production].[Products] AS P
ON P.productid=OD.productid
WHERE OD.unitprice/ P.unitprice <0.95
ORDER BY ReductionPercent 
