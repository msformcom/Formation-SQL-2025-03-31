-- Liste des commandes 
-- | Date commande | Pays de livraison | Nom de la compagnie cliente
-- Ordre DateCommande décroissante
-- pour l'annee 2006 et envoi fait

/*
1) Identifier les tables 
2) Créer la Jointure avec alias
3) Executer pour tester
4) Spécifier SELECT, WHERE, ORDER BY

Date commande | Pays de livraison => Sales.Orders => O
Nom de la compagnie cliente => Sales.Customers => C
*/

SELECT 
	O.orderdate AS DateCommande,
	O.shipcountry AS PaysLivraison,
	C.companyname AS NomCompagnie
FROM [Sales].[Orders] AS O
INNER JOIN [Sales].[Customers] AS C
ON O.custid=C.custid
WHERE YEAR(orderdate)=2006 -- DATEPART(year,orderdate)=2006 
AND O.shippeddate IS NOT NULL
ORDER BY DateCommande DESC
	