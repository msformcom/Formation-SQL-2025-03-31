-- Détail des clients
SELECT *  FROM [Sales].[Customers]

-- Nombre de lignes dans la table clients
SELECT COUNT(*) FROM [Sales].[Customers]

-- Nombre de lignes dans la table clients pour lesquels la region n'est pas NULL
SELECT COUNT(region) FROM [Sales].[Customers]

-- Nombre de valeurs distinctes existant pour le country dans la table client
SELECT COUNT(DISTINCT country) FROM [Sales].[Customers]

-- Les lignes de  [Sales].[Customers] => 91 lignes
SELECT region, country FROM  [Sales].[Customers]

-- Les valeurs distinctes (dédoublonnées) pour region et country de  [Sales].[Customers] => 34 lignes
SELECT DISTINCT region, country FROM  [Sales].[Customers]