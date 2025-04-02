/*
	Liste des produits triés en fonction du CA généré
*/
WITH Source AS (
SELECT 
	P.productid,P.productname,
	P.categoryid,
	SUM(OD.qty*OD.unitprice) AS CA
 FROM [Sales].[OrderDetails] AS OD
INNER JOIN [Production].[Products] AS P ON P.productid = OD.productid
GROUP BY P.productid,P.productname, categoryid)
SELECT *,
	RANK() OVER (ORDER BY CA DESC) AS ClassementCA,
	RANK() OVER (PARTITION BY categoryid ORDER BY CA DESC) AS ClassementCACategory,
	CA/SUM(CA) OVER()*100 AS PercentCAGlobal,
	CA/SUM(CA) OVER(PARTITION BY categoryid)*100 AS PercentCACategory

FROM Source
ORDER BY productname
