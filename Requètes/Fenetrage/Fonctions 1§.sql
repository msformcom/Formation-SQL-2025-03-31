-- Fonctions de fenétrage

SELECT *,
	ROW_NUMBER() OVER (ORDER BY unitprice ASC) AS RowNumber,
	RANK() OVER (ORDER BY unitprice ASC) AS Rank,
	DENSE_RANK() OVER (ORDER BY unitprice ASC) AS DenseRank,
	RANK() OVER (PARTITION BY categoryid ORDER BY unitprice ASC) AS RankInCategory,
	MIN(unitprice) OVER(PARTITION BY categoryid) AS PrixMinDeLaCategorie,
	AVG(unitprice) OVER(PARTITION BY categoryid) AS PrixMoyenDeLaCategorie,
	MAX(unitprice) OVER(PARTITION BY categoryid) AS PrixMaxDeLaCategorie,
	COUNT(*) OVER(PARTITION BY categoryid) AS NbProduitsCategorie,
	unitprice -LAG(unitprice) OVER (PARTITION BY categoryid ORDER BY unitprice) AS DifferencePrecedentDansCat,
	LEAD(unitprice) OVER (PARTITION BY categoryid ORDER BY unitprice)-unitprice AS DifferenceSuivantDansCat
FROM [Production].[Products]
ORDER BY categoryid, unitprice
