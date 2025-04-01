/* 
	Avoir par idProduit =>
	Nombre de ventes
	Quantite vendue,
	CA réalisé
*/

SELECT P.productid,
	P.productname,
		-- COUNT(*),  Compte une ligne à partir du from avec un produit non vendu
		COUNT(qty) AS NbVentes,
		ISNULL( SUM(OD.qty),0) AS QuantiteVendue, --Pas de vente => SUM(OD.qty)=>null => 0
		ISNULL(SUM(OD.unitprice * qty),0) CARealise,
		AVG(OD.unitprice) AS MoyennePrixVenteFaux,
		SUM(OD.unitprice * OD.qty) / SUM(qty) AS MoyennePrixVente
FROM [Sales].[OrderDetails] AS OD
	RIGHT JOIN [Production].[Products] AS P
	ON P.productid=OD.productid
GROUP BY P.productid, P.productname
ORDER BY NbVentes