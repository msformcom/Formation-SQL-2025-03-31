-- Ordre d'exécution des instruction
-- FROM => productid,productname,unitprice
-- WHERE => Filtrage des information utiles
-- SELECT => productid, UPPER(SUBSTRING(productname,1,10)),  unitprice * 1.2 , CASE..
-- ALIAS => 
-- ORDER BY => Utilisation possible des alias

-- Ordre d'apparition des instructions dans la syntaxe
-- SELECT (expressions + Alias) => FROM => WHERE => ORDER BY

SELECT TOP(10)	productid AS 'Id produit', 
				UPPER(SUBSTRING(productname,1,10)) AS 'Nom',
				unitprice * 1.2 'Prix', -- AS facultatif mais bonne pratique
				CASE	WHEN unitprice * 1.2 <30 THEN 'Bon marché' --Impossible de faire référence à l'alias
						WHEN unitprice *1.2 <80 THEN 'Moyen'
						ELSE 'Cher' END AS 'Indication prix',
					discontinued
FROM [Production].[Products]
-- WHERE Condition de selection (Après le FROM dans la syntaxe)
WHERE discontinued!=1 AND 
		unitprice*1.2 BETWEEN 20 AND 30  -- Prix non disponible car filtrage avant Selection
ORDER BY Prix, Nom DESC -- Alias ou nom de colonne d'origine disponibles