SELECT * 
FROM (VALUES(0,50), (50,100),(100,200),(200,5000)) AS T(Min,Max)
/*
CA fonction des prix des produits
 | Min		| Max		| CA		| Nb Produits	| Qte vendue
 | 0		| 50		| 1087897
 | 50		| 100		| 786876
 | 100		| 200		| 677867
 | 200		| 5000		| 165876
*/

 WITH Intervalles AS (
	SELECT * 
	FROM (VALUES(0,50), (50,100),(100,200),(200,5000)) AS T(Min,Max)),
		Source AS (
		SELECT
		   P.unitprice AS PrixProduit,
		   OD.qty * OD.unitprice AS MontantLigne,
		   OD.qty AS Quantite,
		   P.productid AS IdProduit
		 FROM [Sales].[OrderDetails] AS OD 
		INNER JOIN [Production].[Products] AS P ON P.productid=OD.productid
		) ,--  Jointure entre OrderDetails + Products
		Jointure AS (
			SELECT I.Min AS Min,
					I.Max AS Max,
					S.*
		    FROM Intervalles AS I LEFT JOIN Source AS S
			ON S.PrixProduit>=I.Min AND S.PrixProduit<I.Max		
		),--  Joiture entre Intervalles et Source
		GroupementIntervales AS (
			SELECT  Min,
					Max,
					SUM(MontantLigne) AS CA,
					COUNT(DISTINCT IdProduit) AS NbProduits,
					SUM(Quantite) AS QuantiteVendue
			 FROM Jointure
			GROUP BY Min,Max
		) --Regroupement des données par Intervales
 SELECT * FROM GroupementIntervales ORDER BY Min--  Présentation finale