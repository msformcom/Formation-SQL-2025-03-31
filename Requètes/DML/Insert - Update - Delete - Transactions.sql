-- Instruction DML => Data manipulation Language

-- INSERT, UPDATE, DELETE

-- INSERT : Ajout de ligne
-- CREER UNE Catégorie
-- Attention : categoryid est identity => la valeur est générée par la BDD => non spécifiable
-- Je dois donner toutes les valeurs de colonnes NON NULL sans valeur par défaut
INSERT INTO [Production].[Categories] (categoryname,description)
VALUES (N'Deserts',N'For the end of the meal')

SELECT * FROM [Production].[Categories]

-- Suppression de la categorie 9

-- Attention avant d'envoyer car une erreur n'est pas pardonnée

BEGIN TRAN -- Marqueur de début des opérations

-- Opérations sur les données
DELETE FROM [Production].[Categories]
WHERE categoryid=10

-- Vérifiez que les modifs faites sont correctes
SELECT * FROM [Production].[Categories]

ROLLBACK -- ou COMMIT pour valider

SELECT * FROM [Production].[Categories]

-- Je veux insérer la catégorie avec categoryid 9 pas possible par défaut
INSERT INTO [Production].[Categories] (categoryid,categoryname,description)
VALUES (9,N'Deserts',N'For the end of the meal')

-- Pour insérer une ligne avec un id spécifique malgré le compteur
SET IDENTITY_INSERT  [Production].[Categories] ON
INSERT INTO [Production].[Categories] (categoryid,categoryname,description)
VALUES (9,N'Deserts',N'For the end of the meal')
SET IDENTITY_INSERT  [Production].[Categories] OFF

SELECT @@TRANCOUNT -- Nombre de transactions à valider pour terminer les opérations en cours


-- Mise à jour
BEGIN TRAN
BEGIN TRAN

UPDATE [Production].[Products] SET unitprice=unitprice*1.2 -- , SET toto=2...
WHERE unitprice>100 -- Attention condition

SELECT * FROM [Production].[Products] --Verification

COMMIT -- ROLLBACK Validation ou annulation