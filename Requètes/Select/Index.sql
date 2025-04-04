CREATE DATABASE Contacts
GO

CREATE TABLE Personnes (
	Id INT PRIMARY KEY IDENTITY(3,2), -- Id est la clé primaire + Clés automatiques 3,5,7,9
	Nom NVARCHAR(100) NOT NULL,
	PRENOM NVARCHAR(100) NOT NULL
)
GO

INSERT INTO Personnes VALUES ('D','M'),  ('A','H'),  ('Z','B')

SELECT * FROM Personnes

-- Insertion d'un grand nombre d'enregistrement par doublement 
INSERT INTO Personnes
SELECT Nom+'*', Prenom+'*' FROM Personnes

-- recherche non optimisée => regarder dans Query => Include actual plan
-- E/S : Cout 10
SELECT * FROM Personnes
WHERE Nom='D****'

-- Index permettant de trouver un nom très rapidement
CREATE NONCLUSTERED INDEX IX_Nom ON Personnes(Nom)
--DROP INDEX IX_Nom ON Personnes

-- E/S : Cout 0.01 => 1000 fois plus performant
SELECT * FROM Personnes
WHERE Nom='D****'
