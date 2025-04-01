/*
 Sous requètes
*/
-- Nombre de produits par catégorie avec jointure
SELECT C.categoryid, 
		C.categoryname, 
		C.description,
		COUNT(*) AS nbproduits
FROM [Production].[Categories] AS C
INNER JOIN [Production].[Products] AS P ON C.categoryid=P.categoryid
GROUP BY C.categoryid, C.categoryname, C.description

-- Nombre de produits par catégorie avec jointure

SELECT COUNT(*) FROM [Production].[Products]
WHERE categoryid=2

SELECT C.categoryid,
		C.categoryname,
		C.description,
		-- Sous requète : Requète incluse dans la partie SELECT 
		-- qui ramène la valeur à placer dans la colonne
		-- en fonction des données de la requète principale
	(SELECT COUNT(*) FROM [Production].[Products] WHERE categoryid=C.categoryid) AS Nb
FROM [Production].[Categories] AS C