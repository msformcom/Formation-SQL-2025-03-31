SELECT * ,
	-- Colonne en plus : Evolution du CA Par rapoport au mois qui precede
	CA-LAG(CA) OVER(ORDER BY Annee,Mois) AS EvolutionMoisPrecedent,
	-- Ajouter le CA de l'année => calculer le rapport CA / CA année,
	CA/ (SUM(CA) OVER(PARTITION BY Annee))*100 AS PourcentageAn,
	SUM(CA) OVER (PARTITION BY Annee ORDER BY mois ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ),
	-- Evolution du CA par rapport à la moyenne des 3 mois qui précède
	AVG(CA) OVER(ORDER BY annee,mois ROWS BETWEEN 3 PRECEDING  AND 1 PRECEDING)
FROM InfosCADate
ORDER BY Annee, Mois