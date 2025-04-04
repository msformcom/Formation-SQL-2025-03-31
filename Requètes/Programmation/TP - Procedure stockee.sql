-- Procédure stockée
-- AddArticleToCommande Orderid, Productid, qty
-- AddArticleToCommande 14, 16, 6
-- shipdate est null => Erreur Commande déjà livrée
-- article : discontinued = 0 => Produit plus en stock
-- Faire insertion avec unitprice qui est le unitprice de la table product
-- Montant des articles < 10000 => COMMIT sinon ROLLBACK => Commande trop grosse

CREATE OR ALTER PROCEDURE AddArticleToCommande (
	@orderid INT,
	@productid INT,
	@qty INT
)
AS
BEGIN 

	BEGIN TRAN
		BEGIN TRY
			-- 1) Valider les paramètres
			-- La commande existe
			IF NOT EXISTS(SELECT * FROM [Sales].[Orders] WHERE orderid=@orderid)
			BEGIN
				;THROW 50000,'La commande n''existe pas',1;
			END
			ELSE
			BEGIN 
				PRINT 'Commande trouvée'
			END
			-- shipdate est null => Erreur Commande déjà livrée
			IF EXISTS(SELECT * FROM [Sales].[Orders] WHERE orderid=@orderid AND Shippeddate IS NOT NULL)
			BEGIN
				;THROW 50000,'La commande est déjà livrée',1;
			END
			-- article : discontinued = 0 => Produit plus en stock
			-- recherche du produit avec dicontinued=0
			DECLARE @unitprice MONEY
			SELECT @unitprice=unitprice FROM [Production].[Products] WHERE productid= @productid AND discontinued=0
			IF @unitprice IS NULL
			BEGIN
				;THROW 50000,'Le produit n''existe pas ou n''est plus disponible',1;
			END
			--2) Effectuer l'opération
			-- Peut gégérer une erreur à cause de la contrainte sur les prix 
			INSERT INTO [Sales].[OrderDetails] (orderid,productid,unitprice,qty,discount) -- Lister les colonnes
			VALUES (@orderid,@productid,@unitprice,@qty,0)
			
			-- Vérification après insertion
			IF EXISTS(
			SELECT * FROM infoscommandes 
			WHERE idcommande=@orderid AND MontantArticles > 10000)
			BEGIN
				;THROW 50000,'La commande depasse le max autorisé',1;
			END
			-- Tout est OK => COMMIT
			COMMIT
		END TRY
		BEGIN CATCH
			-- Le code du TRY va directement passer ici en cas d'erreur
			ROLLBACK -- Annulation des modifs
			PRINT ERROR_MESSAGE()
			;THROW 50000,'Une erreur s''est produite pendant l''insertion - Opération annulée',1;
		END CATCH
		
END