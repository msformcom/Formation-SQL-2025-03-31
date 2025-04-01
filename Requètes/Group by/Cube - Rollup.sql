/*
	Par pays， annee， mois le CA
	Réalisé par l'employé 4 pour les produits dont le prix >200

	Avec paramtres
*/
DECLARE @empid INT =3;
DECLARE @prixmin MONEY  =10;

-- Les lignes sur lesquelles le regroupement sera effecturé
SELECT		C.country AS Pays,
			DATEPART(year,orderdate) AS Annee, 
			DATEPART(month,orderdate) AS Mois,
			SUM(OD.qty*OD.unitprice)
FROM [HR].[Employees] AS E
RIGHT JOIN [Sales].[Orders] AS O ON E.empid=O.empid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid
INNER JOIN [Production].[Products] AS P ON P.productid=OD.productid
INNER JOIN [Sales].[Customers] AS C ON C.custid=O.custid
WHERE O.empid = @empid AND P.unitprice>=@prixmin
GROUP  BY C.country, DATEPART(year,orderdate), DATEPART(month,orderdate)
--WITH ROLLUP -- Calcul des cumuls partiels en remontant les critères de regroupement
WITH CUBE
ORDER BY Pays, Annee,Mois
