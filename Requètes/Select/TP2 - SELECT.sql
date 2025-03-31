/*
	Tous les employes hommes qui ont plus de 50 ans et qui ont plus de 18 mois d'anciennete
	- NationalIdNumber
	- Genre => Homme ou Femme
	- Age
	- Anciennete (mois)
	Ordonnés par age, anciennete
*/

USE [AdventureWorks]
GO

SELECT -- TOP(10)
	 [NationalIDNumber] AS [NationalIDNumber],
	 CASE WHEN Gender='M' THEN 'Homme'
		ELSE 'Femme' END AS Genre,
	DATEDIFF(year, [BirthDate], GETDATE()) AS Age,
	DATEDIFF(month, [HireDate], GETDATE()) AS Anciennete
FROM [HumanResources].[Employee]
WHERE Gender='M' AND DATEDIFF(year, [BirthDate], GETDATE())>=50
AND DATEDIFF(month, [HireDate], GETDATE())>=18
ORDER BY Age DESC, Anciennete DESC