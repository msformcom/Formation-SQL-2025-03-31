-- Regroupement
-- Fonctions d'agrrégation : COUNT, MIN, MAX, AVG...
-- Transformer plusieurs lignes en 1 seule
SELECT COUNT(*) AS NbProduits,
		MIN(unitPrice) AS PrixMin,
		MAX(unitPrice) AS PrixMax,
		AVG(unitPrice) AS PrixMoyen,
		SUM(unitprice) AS SommeDesPrix
		--productname non valide ici car fait partie du détail
FROM [Production].[Products]


SELECT * FROM [Production].[Products]
ORDER BY categoryid

SELECT COUNT(*) AS NbProduits,  -- Fonction aggegation
		MIN(unitPrice) AS PrixMin, -- Fonction aggegation
		MAX(unitPrice) AS PrixMax, -- Fonction aggegation
		AVG(unitPrice) AS PrixMoyen, -- Fonction aggegation
		SUM(unitprice) AS SommeDesPrix, -- Fonction aggegation
		categoryid  -- Colonnes référencées dans le groupby
		, discontinued
		--productname non valide ici car fait partie du détail
FROM [Production].[Products]
-- WHERE
GROUP BY categoryid, discontinued
 ORDER BY categoryid, discontinued