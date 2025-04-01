/*
 Liste des commandes :
 DateCommande | RaisonSocial du client | Nom employe | Nom compagnie Livraison
*/
-- Utilisation des sous-requètes pour chaque colonne supplémentaire
SELECT O.orderdate,
	(SELECT Companyname FROM [Sales].[Customers] WHERE custid=O.custid) AS Compagnie,
	(SELECT lastname FROM [HR].[Employees] WHERE empid=O.empid) AS NomEmploye,
	(SELECT firstname FROM [HR].[Employees] WHERE empid=O.empid) AS PrenomEmploye,
	(SELECT companyname FROM [Sales].[Shippers] WHERE shipperid=O.shipperid) AS CompagnieLivraison
FROM [Sales].[Orders] AS O

-- je ramène une chaine contenant nom + prenom en une colonne
SELECT O.orderdate,
	(SELECT Companyname FROM [Sales].[Customers] WHERE custid=O.custid) AS Compagnie,
	(SELECT CONCAT(lastname,' ', firstname) FROM [HR].[Employees] WHERE empid=O.empid) AS NomEmploye,
	(SELECT companyname FROM [Sales].[Shippers] WHERE shipperid=O.shipperid) AS CompagnieLivraison
FROM [Sales].[Orders] AS O

-- Pas possible
SELECT O.orderdate,
	(SELECT Companyname FROM [Sales].[Customers] WHERE custid=O.custid) AS Compagnie,
	(SELECT lastname,firstname FROM [HR].[Employees] WHERE empid=O.empid) AS NomEmploye,
	(SELECT companyname FROM [Sales].[Shippers] WHERE shipperid=O.shipperid) AS CompagnieLivraison
FROM [Sales].[Orders] AS O

-- CROSS APPLY : Commode mais performance moindres que JOIN
SELECT O.orderdate, -- colonne 1
	(SELECT Companyname FROM [Sales].[Customers] WHERE custid=O.custid) AS Compagnie, -- colone 2
	E.*, -- toutes les colonnes provenant de E
	E.firstname, -- Une seule colonne de E
	(SELECT companyname FROM [Sales].[Shippers] WHERE shipperid=O.shipperid) AS CompagnieLivraison --colone 3
	 -- Colonnes de la requète suivant le from avec CROSS APPLY
FROM [Sales].[Orders] AS O
-- La sous-requète dans le CROSS APPLY permet d'ajouter les colonnes dans le select
CROSS APPLY (SELECT lastname,firstname FROM [HR].[Employees] WHERE empid=O.empid) AS E


