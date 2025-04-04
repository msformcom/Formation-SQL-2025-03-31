-- Procedure stockée => Ensemble de code auquel on donne un nom pour l'éxécuter à la demande

/*
	Augmenter les prix des produits 1.1 pour 10%
	- pas plus de 10€

	AugmenterPrix 0.1
	=> Augmenter le prix de 10%
	=> faire une erreur si un prix est augmenté de plus de 10€

	Function vs Procedure Stockee =>
	Fonction : pas de modifs des données
*/

CREATE OR ALTER PROCEDURE AugmenterPrix (
	@augmentation DECIMAL(18,3)
)
AS
BEGIN 
	-- 1) Valider les paramètres
	-- Calculer le montant maximal de l'augmentation
	DECLARE @augmentationMax DECIMAL(18,3) =(SELECT max(unitprice*@augmentation) FROM [Production].[Products]);
				IF @augmentationMax >50
				BEGIN
					-- Déclencher une erreur Numero, Message, State
					;THROW 50000,'Cette augmentation entraine une augmentation de prix > 10 €  - Opération annulée',1;
				END
	-- Code la la procédure
	BEGIN TRAN
		BEGIN TRY

			
			--2) Effectuer l'opération
			-- Peut gégérer une erreur à cause de la contrainte sur les prix 
			UPDATE [Production].[Products] SET unitprice=unitprice*(1+@augmentation)
			COMMIT
			SELECT * FROM Production.Products
		END TRY
		BEGIN CATCH
			-- Le code du TRY va directement passer ici en cas d'erreur
			ROLLBACK
			PRINT ERROR_MESSAGE()
			;THROW 50000,'Une erreur s''est produite pendant la mise à jour - Opération annulée',1;
		END CATCH
		
END

--Utilisation dans une transactio avec gestion erreur
BEGIN TRY
	BEGIN TRAN
		EXEC AugmenterPrix 0.01
		SELECT SQRT(-2) -- Cette ligne entraine une erreur dans le bloc => Rollback global => Annulation de l'action de la procéduré
		COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

SELECT SUM(unitprice) FROM Production.Products
-- 2441.2196
