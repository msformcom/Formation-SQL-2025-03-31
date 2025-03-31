USE TSQL;
GO

-- Bonne pratique nomage : Utiliser uniquement lettres latines + _ éviter espaces, accents, les caractères spéciaux
CREATE SCHEMA [Comite Entreprise]
DROP SCHEMA [Comite Entreprise]

SELECT 2+2, 3+4;

-- Obtenir toutes les infos de la table
SELECT * FROM [HR].[Employees]

SELECT GETDATE()

-- Visualiser les premières données d'une table
SELECT TOP 5 * FROM [HR].[Employees]
SELECT TOP 50 PERCENT * FROM [HR].[Employees]

-- Selection de colonne avec alias
SELECT	empid AS 'Id Employe', 
		lastname AS [Nom Employe], 
		firstname AS "Prénom Employe",  -- Pas conseillé
		empid-1 AS IdEmployeExt,
		lastname + ' ' + firstname AS NomComplet,
	    DATEDIFF(year,birthdate,GETDATE()) AS Age
		FROM HR.Employees