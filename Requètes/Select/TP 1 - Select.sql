/*
	
	La liste des produits :
	- IdProduit
	- Nom du produit (10 premiers caractère) en majuscules => Nom Produit
	- prix unitaire + 20% de marge,
	- Bon marché <30, moyen 30 et 80, Cher > 80
*/

SELECT TOP(10) * FROM [Production].[Products]

-- Ordre d'exécution des instruction
-- FROM => productid,productname,unitprice
-- SELECT => productid, UPPER(SUBSTRING(productname,1,10)),  unitprice * 1.2 , CASE..
-- ALIAS => 
SELECT TOP(10)	productid AS 'Id produit', 
				UPPER(SUBSTRING(productname,1,10)) AS 'Nom',
				unitprice * 1.2 'Prix', -- AS facultatif mais bonne pratique
				CASE	WHEN unitprice * 1.2 <30 THEN 'Bon marché' --Impossible de faire référence à l'alias
						WHEN unitprice *1.2 <80 THEN 'Moyen'
						ELSE 'Cher' END AS 'Indication prix'
FROM [Production].[Products]