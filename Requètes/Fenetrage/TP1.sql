/*
	Je veux donner une prime aux 3 employés qui ont fait le plus de vente et jeter les 3 employés avec le moins de ventes
	nom prenom CA absolu, Percentage CA, Rank dans le classement des employe
	Pour 2007
*/

WITH Source AS (
	SELECT 
	E.empid AS IdEmploye,
	E.firstname AS NomEmploye,
	E.lastname AS PrenomEmploye,
	OD.qty AS Quantite,
	OD.unitprice AS PrixVente
	FROM [HR].[Employees] AS E 
	LEFT JOIN [Sales].[Orders] AS O ON O.empid=E.empid
	INNER JOIN [Sales].[OrderDetails] AS OD ON OD.orderid=O.orderid
	WHERE YEAR(orderdate)=2007
),
Groupes AS (
SELECT IdEmploye,
		NomEmploye,
		PrenomEmploye,
SUM(Quantite*PrixVente) AS CA 
FROM Source
GROUP BY IdEmploye,
		NomEmploye,
		PrenomEmploye
)

SELECT *,
	RANK() OVER(ORDER BY CA DESC) AS ClassemntCA,
	CA/SUM(CA) OVER() *100 AS PercentCAGeneré,
	-- Séparation des lignes en fonction du CA en 5 groupes
	NTILE(3) OVER(ORDER BY CA DESC) AS Classement5

 FROM Groupes