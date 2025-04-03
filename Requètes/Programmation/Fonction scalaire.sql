-- Problème si réutilisation du code => Mises à jour partout où le code est utilsé
SELECT productname, unitprice,
	CASE WHEN unitprice<50 THEN 'Pas Cher'
		WHEN unitprice <100 THEN 'Moyen'
		ELSE 'Cher' END AS IndicationPrix
FROM [Production].[Products]

SELECT productname, 
		unitprice,
		dbo.IndicationPrix(unitprice) -- Fonction => ecrire le code séparément
FROM [Production].[Products]

GO
-- Création fonction scalaire => Prend des paramètre qui renvoit une valeur
CREATE OR ALTER FUNCTION IndicationPrix(
	@prix DECIMAL(18,4)
	--, @Param2 INT...
	)
	RETURNS NVARCHAR(100)
AS BEGIN

RETURN CASE WHEN @prix<5 THEN 'Pas Cher'
		WHEN @prix <100 THEN 'Moyen'
		ELSE 'Cher' END 
END





