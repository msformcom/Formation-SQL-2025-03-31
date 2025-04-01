/*
 Selectionner le CA réalisé, le nombre ventes, le nombre de clients 
 par pays,region, ville

 1) Quelles tables + Quelles jointure
 2) Premier SELECT + order by
 3) Ajouter group by + modification du SELECT pour avoir les infos désirées

*/
SELECT C.country, C.region,C.city ,* FROM [Sales].[Customers] AS C
INNER JOIN [Sales].[Orders] AS O ON C.custid=O.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
ORDER BY C.country, C.region,C.city

-- FROM => WHERE => GROUP BY => HAVING => SELECT => ORDER BY
SELECT		ISNULL(C.country,'---') AS Pays, 
			ISNULL(C.region,'---') AS Region, 
			ISNULL(C.city,'---') AS Ville, 
			SUM(OD.qty*OD.unitprice) AS CA,
			COUNT(DISTINCT OD.orderid) AS NbCommandes,
			COUNT(DISTINCT O.custid) AS NbClients
FROM [Sales].[Customers] AS C
RIGHT JOIN [Sales].[Orders] AS O ON C.custid=O.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
WHERE YEAR(O.orderdate)=2006 -- Filtre sur les données de la table à prendre en compte
GROUP BY C.country, C.region,C.city
HAVING SUM(OD.qty*OD.unitprice)>1000 -- Filtre sur les données une fois le regroupement effectué
ORDER BY C.country, C.region,C.city