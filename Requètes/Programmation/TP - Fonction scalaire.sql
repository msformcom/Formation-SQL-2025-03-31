-- Créer une fonction euros qui ajoute le signe euro à une valeur
-- Permet d'éviter de répéter des formules / expressions de calcul
-- MAJ fonction => MAJ Des requètes qui l'utilisent
SELECT productname, 
	FORMAT(unitprice,'c','fr-FR'),
	sales.currency(unitprice) --=> Raquette , 45.00 €
FROM [Production].[Products]

-- Je nomme la fonction assez générique
CREATE OR ALTER FUNCTION sales.currency(
	@prix DECIMAL(18,4)
	--, @Param2 INT...
	)
	RETURNS NVARCHAR(100)
AS BEGIN

RETURN FORMAT(@prix,'c','en-US')
END