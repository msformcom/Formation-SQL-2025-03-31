-- Fonction scalaire => 1 résultat de type valeur
-- Je nomme la fonction assez générique
CREATE OR ALTER FUNCTION sales.currency(
	@prix DECIMAL(18,4)
	--, @Param2 INT...
	)
	RETURNS NVARCHAR(100) -- Definition du type du résultat
AS BEGIN
	-- Calculer le résultat (avec algorythmique)
	DECLARE @r NVARCHAR(100)=FORMAT(@prix,'c','en-US')
	SET @r=@r+' '
	RETURN @r -- Renvoyer le résultat calculé
END

GO

-- Création et utilisation de la fonction renvoyant des enregistrement
CREATE OR ALTER FUNCTION AnneesMoisF(
	@annee1 INT,
	@annee2 INT
) RETURNS TABLE -- Indiquer le type de resultat => Table => Enregistrements
AS RETURN 
-- Définir le résultat sous forme de SELECT
WITH Annees AS (
SELECT n AS Annee FROM Nums WHERE n BETWEEN @annee1 AND @annee2),
 Mois AS (
SELECT n AS Mois FROM Nums WHERE n BETWEEN 1 AND 12)
SELECT * FROM annees CROSS JOIN Mois

GO -- Sans le go le SELECT n'est pas valide (fonction pas encore enregistree)

SELECT * FROM AnneesMoisF(2005,2009) -- => Combinaisons annees, mois entre 2005 et 2009

GO

-- Définition d'une fonction en utilisant une autre fonction
CREATE OR ALTER FUNCTION InfosCADateF(
	@annee1 INT,
	@annee2 INT
) RETURNS TABLE -- Indiquer le type de resultat => Table => Enregistrements
AS RETURN 
SELECT AM.Annee, AM.mois, ISNULL(SUM(I.MontantTotal), 0) AS CA
FROM            dbo.AnneesMoisF(@annee1,@annee2) AS AM LEFT OUTER JOIN
   dbo.InfosCommandes AS I ON AM.Annee = YEAR(I.DateCommande) AND AM.mois = MONTH(I.DateCommande)
GROUP BY AM.Annee, AM.mois

GO

SELECT * FROM InfosCADateF(2005,2009)
ORDER BY Annee,Mois -- Uniquement en dernier 