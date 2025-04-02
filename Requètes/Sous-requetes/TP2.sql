/*
	Afficher le CA par annee et mois pour 2006 à 2008 sans "trous"
	Dans un CTE
	1) Definir la selection des années => Annees
	2) Definir la selection des mois => Mois
	3) Definir la combinaison Annees CROSS JOIN Mois => Dates
	4) Definir la source des données à partir des tables Orders et OrderDetails + GroupBY => Annee,Mois, CA => Source => Avec trous
	5) Jointure Dates LEFT JOIN Source 

	WITH	Annees AS (....), -- Liste des années
			Mois AS (....), -- Liste des mois
			Dates AS (....), -- Combinaison Annees + Mois
			Source AS (....), -- Données des tables (jointure faite)
			SourceGroups AS (...), -- Regroupement des données par annee et mois => Trous
			DatesSource AS (...) -- Jointure entre Dates et Regroupements de données
			SELECT .... -- Finalisation de la requète

*/

	WITH	Annees AS (SELECT n as Annee FROM Nums WHERE n BETWEEN 2006 AND 2008), -- Liste des années
			Mois AS (SELECT n as Mois FROM Nums WHERE n BETWEEN 1 AND 12), -- Liste des mois
			Dates AS (
				SELECT * FROM Annees,Mois
			), -- Combinaison Annees + Mois
			Source AS (
				SELECT YEAR(O.orderdate) AS AnneeCommande,
						MONTH(O.orderdate) AS MoisCommande,
						OD.qty*OD.unitprice AS MontantLigneCommande 
				FROM [Sales].[Orders] AS O
				INNER JOIN [Sales].[OrderDetails] AS OD ON OD.orderid=O.orderid
			), -- Données des tables (jointure faite)
			SourceGroups AS (
				SELECT AnneeCommande,MoisCommande, 
					SUM(MontantLigneCommande) AS CA
				FROM Source
				GROUP BY AnneeCommande, MoisCommande
			
			) , -- Regroupement des données par annee et mois => Trous
			DatesSource AS (
				SELECT * FROM 
				Dates AS D LEFT JOIN SourceGroups AS SG ON 
						D.Annee=SG.AnneeCommande AND D.Mois=SG.MoisCommande
			) -- Jointure entre Dates et Regroupements de données
			SELECT Annee,Mois,
					ISNULL(CA,0) AS CA FROM DatesSource -- Finalisation de la requète
				ORDER BY Annee,Mois