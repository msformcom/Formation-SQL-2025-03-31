SELECT * FROM [Production].[Products]

SELECT * FROM [Production].[Categories]

-- productid  | Nom produit |Prix | Nom Categorie

-- Utilisation de jointure avec WHERE => Eviter
SELECT productid,
		productname,
		unitprice, 
		categoryname
 FROM [Production].[Products],[Production].[Categories]  -- Jusqu'ici toutes les combinaisons possible
WHERE unitprice >20 -- Filtre
AND
[Production].[Products].categoryid = [Production].[Categories].categoryid -- Assurer la jointure

-- Utilisation de jointure JOIN + ON sans Alias
SELECT productid,
		productname,
		[Production].[Categories].categoryid AS 'Id Categorie',
		unitprice, 
		categoryname
FROM [Production].[Products]  -- Table 1
INNER JOIN [Production].[Categories]   -- Table 2
ON [Production].[Categories].categoryid = [Production].[Products].categoryid
-- INNER JOIN ... Table 3
-- ON ...
WHERE unitprice >20 -- Filtre

-- Utilisation de jointure JOIN + ON avec Alias
SELECT	P.productid,  -- Préfixer avec l'alias de la table est une bonne pratique
		P.productname,
		C.categoryid AS 'Id Categorie',
		P.unitprice, 
		C.categoryname
FROM [Production].[Products] AS P -- Table 1
INNER JOIN [Production].[Categories] AS C  -- Table 2
ON P.categoryid = C.categoryid
-- INNER JOIN ... Table 3
-- ON ...
WHERE P.unitprice >20 -- Filtre
ORDER BY P.unitprice

