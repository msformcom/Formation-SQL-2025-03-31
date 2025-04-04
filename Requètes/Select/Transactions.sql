/*
Transaction : Ensemble d'instructions qui répond à une certain nombre de contraintes
A : Atomicité => TOUT OU RIEN
C : Cohérence
I : ISolation : Les do,,ées sont verrouillées pendant le cours d'une transaction => evite des conflits ou des lectures fausses
D : Durabilite => une transaction terminée doit rester dans la bDD => Sauvegardée de manière durable
*/

SELECT * FROM [Production].[Products]

-- Coté utilisateur 1
BEGIN TRAN
UPDATE [Production].[Products] SET unitprice=unitprice+1 WHERE productid=5
-- Les autres utilisateurs seront bloqués sur une requète :
--SELECT * FROM [Production].[Products]
-- Jusqu'à la fin de la transaction 

SELECT * FROM [Production].[Products]
-- Autres instruction longues
COMMIT


-- Coté utilisateur 2
-- Changer de niveau d'isolation de transaction pour lire les données même celles non commitees
-- SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
-- Ici, je lis les données avec une certaine incertitude
-- Lecture sans attente
SELECT * FROM [Production].[Products] --=> Bloquée sauf niveau isolation READ UNCOMMITTED




