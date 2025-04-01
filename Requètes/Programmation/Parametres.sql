/*
 Selectionner le CA réalisé, le nombre ventes, le nombre de clients 
 par pays,region, ville pour l'année 2006 (uniquement si CA > 1000)

 1) Quelles tables + Quelles jointure
 2) Premier SELECT + order by
 3) Ajouter group by + modification du SELECT pour avoir les infos désirées


SELECT C.country, C.region,C.city ,* FROM [Sales].[Customers] AS C
INNER JOIN [Sales].[Orders] AS O ON C.custid=O.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
ORDER BY C.country, C.region,C.city
*/
-- FROM => WHERE => GROUP BY => HAVING => SELECT => ORDER BY

-- Paramtre de la requete 
-- - commence par @
-- - uniquement des lettres et _ pour le nom
-- - Type
-- - valeur
DECLARE @annee INT= 2007;
DECLARE @camin MONEY =1000;


-- Utilisation des paramtres au lieu de valeurs dans la requète

SELECT		ISNULL(C.country,'---') AS Pays, 
			ISNULL(C.region,'---') AS Region, 
			ISNULL(C.city,'---') AS Ville, 
			SUM(OD.qty*OD.unitprice) AS CA,
			COUNT(DISTINCT OD.orderid) AS NbCommandes,
			COUNT(DISTINCT O.custid) AS NbClients
FROM [Sales].[Customers] AS C
RIGHT JOIN [Sales].[Orders] AS O ON C.custid=O.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
WHERE YEAR(O.orderdate)=@annee -- Filtre sur les données de la table à prendre en compte
GROUP BY C.country, C.region,C.city
HAVING SUM(OD.qty*OD.unitprice)> @Camin -- Filtre sur les données une fois le regroupement effectué
ORDER BY C.country, C.region,C.city