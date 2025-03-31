-- Changement de contexte => TSQL
USE TSQL
-- Executer l'instruction du dessus avant de passer à la suite
GO

-- Obtention des données de la table  HR.Employees
-- SQL n'est pas sensible à la casse => Minuscules / Majuscules indiférent
-- Par convention => Les clauses (SELECT, FROM) est écrit en majuscule
SELECT * FROM HR.Employees

-- Liste des tables => Metadata => Spécifique SQL Server
SELECT * FROM sys.tables
SELECT * FROM sys.databases
-- Liste des colonnes de l'object (Table) avec object_id=245575913
SELECT * FROM sys.columns WHERE object_id=245575913

-- Liste des tables => Metadata => Standart
SELECT * FROM INFORMATION_SCHEMA.TABLES
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA
SELECT * FROM INFORMATION_SCHEMA.COLUMNS


