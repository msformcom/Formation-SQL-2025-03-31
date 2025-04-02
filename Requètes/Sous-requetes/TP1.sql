/*
	Liste des ventes produits 
	Nom produit | Nom fournisseur | Pays fournisseur | Nombre d'employés qui ont vendu ce produit

	-- Sous-requetes uniquement
	-- Sous requètes + cross apply
	-- Join
*/


SELECT	*,
		-- Nom du fournisseur
		(SELECT CompanyName 
			FROM [Production].[Suppliers] 
			WHERE supplierid=P.supplierId) AS NomFournisseur,
		-- Pays du fournisseur
		(SELECT Country 
			FROM [Production].[Suppliers] 
			WHERE supplierid=P.supplierId) AS PaysFournisseur,
		-- Nombre d'employés associés à la vente du produit avec P.productid
		(SELECT COUNT(DISTINCT empid)
			FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD
			ON O.orderid = OD.orderid
			WHERE OD.productid=P.productid
			) AS NbEmployes
FROM [Production].[Products] AS P



SELECT	P.*,
		-- Resultats du cross apply
		S.*,
		-- Nombre d'employés associés
		(	SELECT COUNT(DISTINCT empid )
			FROM [Sales].[Orders] AS O INNER JOIN [Sales].[OrderDetails] AS OD
			ON O.orderid = OD.orderid
			WHERE OD.productid=P.productid
		) AS NbEmployes
FROM [Production].[Products] AS P
CROSS APPLY (	-- Sous-requète pour les supplier
				SELECT CompanyName AS ShipperName, 
					Country AS ShipperCountry
				FROM [Production].[Suppliers] 
				WHERE supplierid=P.supplierId) AS S
