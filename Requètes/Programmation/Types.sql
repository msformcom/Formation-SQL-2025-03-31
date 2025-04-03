--SET DATEFORMAT DMY
--DECLARE @Date DATE ='10/01/2008';
--SELECT MONTH(@Date)

---- Types entiers 
---- Bit 0 ou 1
---- TINYINT 0-255
---- SMALLINT -32768 32767
---- INT -
--DECLARE @d INT =6
--SET @d=5/2
--SELECT @d

---- Types numeriques à virgule
---- FLOAT(18,2) => 18 chiffres dont 2 chiffres après la virgule => Precis
---- FLOAT real => Imprecis

/*
FLOAT a=1.3 => 1.29999999999 ou 1.3000000002 
	1.2 => 1010101010101101010101001
+	1.9 => 1010101010010101010101011
--------------------------------------
			10101010101010010101010 => 3.0999999999998 => 1 cycle microproc
Données meteo => Millions calculs => Toulouse demaine matin 12.6757657567 => 20 minutes
compta => 1897987978979879 pins vendus a à 0.0067€ le pins => 19879187987981.98

DECIMAL => a=1.3     1.3     
	1.2
+	1.9
--------
	3.1 => 1000 cycles proc
Données meteo => Millions calculs => Toulouse demaine matin 12.6757657592 => 2 jours
compta => 1897987978979879 pins vendus a à 0.0067€ le pins => 19879187987981.92 vrai
*/
DECLARE @a FLOAT=0.3; -- => 0.2
DECLARE @b FLOAT=0;
DECLARE @i FLOAT=0;

WHILE @i <>50
BEGIN 
	SET @b=@b+@a
	SET @i=@i+1
END
PRINT @b
if @b=15
BEGIN 
	PRINT @b
END


-- Alpha numérique

DECLARE @message CHAR(40)='Bonjour' -- 'Bonjour                                  '
DECLARE @message2 VARCHAR(20)='中國人' -- 'Bonjour' Max 40 char
-- Valeur tronquée
SET @message2='mqskljlmqjdlkjqlsfj qlkfj lqkj flqj fljkqlkfj lqk jfjlk'
SELECT @message2
-- UPDATE Annulé
UPDATE [Production].[Products] SET [productname]='782 87 872 87 287 827 78 868218187 87 8è _ I JKGHJGJGHJ GJGJ J JHGH JZGH JZGZJGZ JZG ZJGZJG ZJG'
WHERE Productid=72

DECLARE @messageEtranger VARCHAR(150)='中國人'
-- VARCHAR => Encodage ASCII => é => 45   人=> ?
SELECT @messageEtranger

DECLARE @messageEtranger2 NVARCHAR(150)=N'中國人' -- NVARCHAR(MAX)
-- VARCHAR => Encodage unicode => é => 45   人=> 15 67 87 56
SELECT @messageEtranger2

-- Document => VARBINARY(1000) VARBINARY(MAX)
