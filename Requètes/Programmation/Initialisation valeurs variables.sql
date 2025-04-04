-- Utilisation de la fonction InfosCADateF avec paramètres fixes

SELECT * FROM InfosCADateF(2005,2009)

-- paramètre spécifié manuellement
DECLARE @annee1 INT =2006;
-- paramètre calculé par sous requète
DECLARE @annee2 INT =(SELECT MAX(YEAR(orderdate)) FROM [Sales].[Orders]);
--SELECT * FROM InfosCADateF(@annee1,@annee2)

-- Ce select ne sert qu'à donner des valeurs aux paramètres 
SELECT @annee1=MIN(YEAR(orderdate)) ,
		@annee2=MAX(YEAR(orderdate))
FROM [Sales].[Orders]

SELECT @annee1,@annee2
-- Utilisation des paramètres dans une fonction
SELECT * FROM InfosCADateF(@annee1,@annee2)
