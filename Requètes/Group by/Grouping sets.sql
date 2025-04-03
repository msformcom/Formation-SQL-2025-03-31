/*
	Avoir les infos suivantes :
	Une vue avec InfosVentesProduit
	Par annee / mois
	Annee | Mois | Categorie produit | Nom Produit | Prix Catalogue | Qte Vendue | CA Genere | Moyenne Prix vente
	- Orders
	- OrderDetails
	- Products
	- Categories

	Orders + OrderDetails => InfosVentes
	Products + Categories => InfosProduits

	A partir des résultats de la vue, écrire des requètes qui donnent :
	 Trouver les informations pour tous les produits pour 2007
	 Trouver pour categorie 3 pour Janvier 2008
	 Trouver pour le produit 72 en 2007
	 La proportion de CA généré pour chaque catégorie en 2007
*/

-- InfosVentes
CREATE OR ALTER VIEW InfosVentes AS
SELECT O.OrderID,
		O.OrderDate,
		O.shippeddate,
		O.shipperid,
		O.shipcountry,
		O.empid,
		OD.qty,
		OD.unitprice AS SalePrice,
		OD.productid
 FROM [Sales].[Orders] AS O
INNER JOIN [Sales].[OrderDetails] AS OD ON OD.orderid=O.orderid
GO
CREATE OR ALTER VIEW InfosProduits AS
SELECT P.productid,
		P.productname,
		P.unitprice AS catalogPrice,
			P.productname,
		P.categoryid,
		C.categoryname
 FROM [Production].[Products] AS P
INNER JOIN [Production].[Categories] AS C ON C.categoryid=P.categoryid
GO
CREATE OR ALTER VIEW InfosVentesProduit AS
SELECT YEAR(V.orderDate) AS Year,
			MONTH(V.orderdate) AS Month,
			P.productid,
			P.productname,
			P.catalogPrice,
			P.categoryid,
			P.categoryname,
			SUM(V.qty) AS qty,
			SUM(V.qty*V.SalePrice) AS CA,
			SUM(V.qty*V.SalePrice)/SUM(Qty) AS AveragePrice
FROM InfosVentes V 
INNER JOIN InfosProduits AS P ON P.productid=V.productid
GROUP BY GROUPING SETS(
			(YEAR(V.orderDate)),
			(MONTH(V.orderdate)),
			(YEAR(V.orderDate),MONTH(V.orderdate)),
			(P.productid,P.productname,P.catalogPrice),
			(P.categoryid, P.categoryname),
			(YEAR(V.orderDate), P.categoryid, P.categoryname),
			(YEAR(V.orderDate),P.productid,P.productname,P.catalogPrice)
			)
			
GO

-- ventes Tous produits, Tous mois Pour 2007
SELECT * FROM InfosVentesProduit
WHERE
 year =2007
AND MONTH IS NULL
AND ProductId IS NULL
AND categoryid IS NULL

-- janvier 2008 categorie 3
SELECT * FROM InfosVentesProduit
WHERE
 year =2007
AND MONTH IS NULL
AND categoryid=3

-- Annee 2002 produit 72
SELECT * FROM InfosVentesProduit
WHERE
 year =2007
AND MONTH IS NULL
AND productid=76