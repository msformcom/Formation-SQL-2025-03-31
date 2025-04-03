/*
1) Creer la vue InfosCommandes à partir de la requète dans la conversation => CREATE VIEW
2) Ajouter à cette vue les Pays region Ville Livraison => ALTER VIEW OU CREATE OR ALTER
3) Créer une nouvelle requète se basant sur cette vue pour avoir le CA en fonction des annees - mois
	sans trous pour 2006 - 2008
4) Créer une vue qui s'appelle InfosCA2006a2008
*/

-- 1) Creer la vue InfosCommandes à partir de la requète dans la conversation => CREATE VIEW
CREATE  OR ALTER VIEW InfosCommandes
AS
SELECT O.orderid AS IdCommande, 
		O.custid AS IdClient,
		O.empid AS IdEmploye, 
		O.shipperid AS IdLivreur, 
		O.orderdate AS DateCommande, 
		O.shippeddate AS DateLivraison, 
		SUM(OD.qty * OD.unitprice) AS MontantArticles,
        O.freight AS PrixLivraison, 
		SUM(OD.qty * OD.unitprice) + O.freight AS MontantTotal
FROM    Sales.Orders AS O 
		INNER JOIN Sales.OrderDetails AS OD ON OD.orderid = O.orderid
GROUP BY O.orderid, O.custid, O.empid, O.shipperid, O.orderdate, O.freight, O.shippeddate

-- 2) Ajouter à cette vue les Pays region Ville Livraison => ALTER VIEW OU CREATE OR ALTER
CREATE  OR ALTER VIEW InfosCommandes
AS
SELECT O.orderid AS IdCommande, 
		O.custid AS IdClient,
		O.empid AS IdEmploye, 
		O.shipperid AS IdLivreur, 
		O.orderdate AS DateCommande, 
		O.shippeddate AS DateLivraison, 
		SUM(OD.qty * OD.unitprice) AS MontantArticles,
        O.freight AS PrixLivraison, 
		SUM(OD.qty * OD.unitprice) + O.freight AS MontantTotal,
		O.shipcountry AS PaysLivraison,
		O.shipregion AS RegionLivraison,
		O.shipcity AS VilleLivraison
FROM    Sales.Orders AS O 
		INNER JOIN Sales.OrderDetails AS OD ON OD.orderid = O.orderid
GROUP BY O.orderid, O.custid, O.empid, O.shipperid, O.orderdate, O.freight, O.shippeddate,
		O.shipcountry,O.shipregion, O.shipcity

-- 3) Créer une nouvelle requète se basant sur cette vue pour avoir le CA en fonction des annees - mois sans trous pour 2006 - 2008
-- Annees
-- Vue années 2006 - 2008 (Modifiable au fil du temps mais manuellement)
CREATE OR ALTER  VIEW AnneesDeuxPassees
AS
SELECT n AS Annee FROM Nums WHERE 
n BETWEEN 2006 AND 2008 

-- Vue 2 dernières années calculées fonction date courante
CREATE OR ALTER  VIEW AnneesDeuxPassees
AS
SELECT n AS Annee FROM Nums WHERE 
n BETWEEN YEAR(GETDATE())-3 AND YEAR(DATEADD(year,-1,GETDATE()))

-- View dépendante d'une autre view
CREATE VIEW AnneesMoisDeuxPassees
AS
SELECT * FROM AnneesDeuxPassees A
CROSS JOIN (SELECT n AS mois FROM nums WHERE n BETWEEN 1 AND 12) AS Mois

-- View annees fonction des données dans les commande
CREATE OR ALTER VIEW Annees
AS
SELECT n AS Annee
 FROM Nums WHERE 
n BETWEEN (SELECT MIN(YEAR(OrderDate)) FROM Sales.Orders) 
AND (SELECT MAX(YEAR(OrderDate)) FROM Sales.Orders)

-- Vue de CA
CREATE OR ALTER VIEW InfosCADate
AS
SELECT  AM.Annee,
		AM.Mois,
		ISNULL(SUM(I.MontantTotal),0) AS CA
 FROM AnneesMoisDeuxPassees AS AM
	LEFT JOIN InfosCommandes I ON AM.Annee=YEAR(I.DateCommande) AND AM.mois=MONTH(I.DateCommande)
	GROUP BY AM.Annee,AM.Mois



