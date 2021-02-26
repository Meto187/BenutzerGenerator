USE [master]
GO
/****** Object:  StoredProcedure [dbo].[Metin_BenutzerGenerator]    Script Date: 26.02.2021 12:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER              PROCEDURE [dbo].[Metin_BenutzerGenerator]
(	
	@inUserId		decimal(11,0)
	--	
	,@inBenutzerKennung char(40)                                                                                           
	,@inPassWort char(40)                                                                                                                                                                                      
	,@inBenutzerName char(80)                                                                                              
	,@inUserEMail varchar(255)                                                                                            
	,@inUserTelefon varchar(255)                                                                        
	,@inANSFId decimal(11) 
                                                                                                                                                                                                                                                                                                                                                                                  
	,@inUGRPId decimal(11)  
	--
	,@outInfo		nvarchar(4000) output
	,@outMeldung	nvarchar(4000) output
	,@outResult		decimal(38,0) output 
)
AS

DECLARE	@StartZeit datetime
SET 	@StartZeit = GetDate()
----------------------------------------------
DECLARE @parNL char(2)
SET @parNL = CHAR(13) + char(10)
----------------------------------------------
DECLARE	@Modul decimal(11,0)
DECLARE @parLogLevel decimal(4)
DECLARE @parModulName nvarchar(128)
--
-- ************************************************************************************************
-- Deklarationsteil der lokalen Variablen
--*************************************************************************************************
----------------------------------------------*
-- Parameter Programmsteuerung
----------------------------------------------*
DECLARE	@flag		INT
DECLARE	@SQL1ERR	INT
DECLARE	@SQL2ERR	INT
DECLARE	@SQL3ERR	INT
DECLARE	@SQL4ERR	INT
DECLARE	@SQL5ERR	INT
DECLARE	@SQL6ERR	INT
DECLARE	@SQL7ERR	INT
DECLARE	@SQL8ERR	INT
DECLARE	@SQL9ERR	INT
DECLARE	@SQL10ERR	INT
DECLARE	@SQL11ERR	INT
DECLARE	@SQL12ERR	INT
DECLARE	@SQL13ERR	INT
DECLARE	@SQL14ERR	INT
DECLARE	@SQL15ERR	INT
-----------------------
DECLARE	@ROWS1		INT
DECLARE	@ROWS2		INT
DECLARE	@ROWS3		INT
DECLARE	@ROWS4		INT
DECLARE	@ROWS5		INT
DECLARE	@ROWS6		INT
DECLARE	@ROWS7		INT
DECLARE	@ROWS8		INT
DECLARE	@ROWS9		INT
DECLARE	@ROWS10		INT
DECLARE	@ROWS11		INT
DECLARE	@ROWS12		INT
DECLARE	@ROWS13		INT
DECLARE	@ROWS14		INT
DECLARE	@ROWS15		INT
----------------------------------------------*
-- CATCH Error Handling
----------------------------------------------*
DECLARE @parERROR_NUMBER		int
DECLARE @parERROR_SEVERITY		int
DECLARE @parERROR_STATE			int
DECLARE @parERROR_PROCEDURE		varchar(max)
DECLARE @parERROR_LINE			varchar(max)
DECLARE @parERROR_MESSAGE		varchar(max)
----------------------------------------------*
-- _USER    
----------------------------------------------*
DECLARE @parUSERUSERId decimal(11,0)
DECLARE @parUSERBenutzerKennung char(40)
DECLARE @parUSERPassWort char(40)
DECLARE @parUSERBenutzerName char(80)
DECLARE @parUSERUserMarkeErstellung datetime
SET @parUSERUserMarkeErstellung = GETDATE()
--
DECLARE @parInBenutzerKennung char(40)                                                                                          
DECLARE @parInPassWort char(40)                                                                                                   
DECLARE @parInPersonalNummer decimal(11)                                                                                          
DECLARE @parInBenutzerName char(80)                                                                                               
DECLARE @parInUserEMail varchar(255)                                                                                              
DECLARE @parInUserTelefon varchar(255)                                                                                           
DECLARE @parInLoeschKennZeichen char(1)                                                                                                                                                                                 
DECLARE @parInANSFId decimal(11)   
DECLARE @parInUSERId decimal(11)  
DECLARE @parInArt char(40)                                                                                                                                                                                             
DECLARE @parInUGRPId decimal(11)
Declare @parInMANDId decimal(11)
----------------------------------------------*
-- Sonstige Variablen
----------------------------------------------*
DECLARE @parAnzahlBenutzer int = 0
DECLARE @RESULT INT  = 0

----------------------------------------------*
-- [_Anschriften]
----------------------------------------------*
Declare @parInName1 varchar (255)
		,@parInName2 varchar (255)
		,@parInName3 varchar (255)
		,@parInStrasse varchar(255)
		,@parInLand char(80)
		,@parInPLZ char(10)
----------------------------------------------*
----------------------------------------------*
-- Ausführen von Stored Proceduren
----------------------------------------------*

-- ************************************************************************************************
-- BEGINn des Hauptteils
-- ************************************************************************************************
SET @flag = 0
----------------------------------------
-- InitialISierung der Ausgabeparameter
----------------------------------´-----
-- 
SET @outInfo = ''
SET @outMeldung = ''
SET @outResult = 0
----------------------------------------
--  Prüfung der Eingabeparameter
----------------------------------´-----
--

-----------------------------------------------------------------------------------------*
---- Default Werte für @inUserId
-----------------------------------------------------------------------------------------*
---
IF @inUserId = 0
	BEGIN
		SET @inUserId = 1
END
---
-----------------------------------------------------------------------------------------*
---- wir prüfen, ob es den Benutzer in _USER gibt, und er nicht gelöscht ISt
-----------------------------------------------------------------------------------------*
IF @flag = 0
	BEGIN
		  SELECT 
				@parUSERUSERId = USERId -- decimal(11,0)
				,@parUSERBenutzerKennung = BenutzerKennung -- char(40)
				,@parUSERPassWort = BenutzerKennung -- char(40)
				,@parUSERBenutzerName = BenutzerName -- char(80)
				,@parUSERUserMarkeErstellung = UserMarkeErstellung -- decimal(11,0)
			FROM   [master].[dbo].[_USER]
			WITH   (NOLOCK)
			WHERE  USERId = @inUSERId
			---
			SELECT @SQL1ERR = @@ERROR, @ROWS1 = @@ROWCOUNT
			---
			IF @SQL1ERR <> 0
			BEGIN
				SET @flag = @flag + 1024
				SET @outResult = 5024			-- Farbe rot
				SET @outMeldung = LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [SQLFehler bei ZugrIFf auf _USER]' + '; '
			END
			---
			IF @ROWS1 < 1 
			BEGIN
			----------------------------------
			--- wir haben keine Rows gefunden
			----------------------------------
				SET @flag = @flag + 1024
				SET @outResult =  5025			-- Farbe rot
				SET @outMeldung = LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [Benutzer nicht gefunden]' + '; '
			END
			---
			IF @ROWS1 > 1 
			BEGIN
			----------------------------------
			--- wir haben zuviele Rows gefunden
			----------------------------------
				
				SET @flag = @flag + 1024
				SET @outResult = 5028			-- Farbe rot
				SET @outMeldung = LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [Benutzer mehrdeutig]' + '; '
			END
			---
			IF @ROWS1 = 1
			BEGIN
				SET @flag = @flag + 1024
				SET @outResult = 5029			-- Farbe rot
				SET @outMeldung = LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [Benutzer ISt gelöscht]' + '; '
			END
			---
END
-----------------------------------------------------------------------------------------*
---- Variablen Werte Zuweisen
-----------------------------------------------------------------------------------------*
IF @flag = 0
BEGIN
	BEGIN TRY
		-----
		IF NOT @inBenutzerKennung IS NULL
		and @inBenutzerKennung <> ''
		BEGIN
				SET                     @parInBenutzerKennung = @inBenutzerKennung
		END
		---
		IF NOT @inPassWort IS NULL
		and @inPassWort <> ''
		BEGIN
				SET						@parInPassWort = @inPassWort
		END
		---
		IF NOT @InBenutzerName IS NULL
		and @inBenutzerName <> ''
		BEGIN
				SET						@parInBenutzerName = @inBenutzerName
		END
		---
		IF NOT @InUserEMail IS NULL
		and @InUserEMail <> ''
		BEGIN
				SET						@parInUserEMail = @inUserEMail
		END
		---
		IF NOT @InUserTelefon IS NULL
		and @InUserTelefon <> ''
		BEGIN
				SET						@parInUserTelefon = @inUserTelefon
		END
		---
		IF NOT @InANSFId IS NULL
		and @inANSFId <> '0'
		BEGIN
				SET						@parInANSFId = @inANSFId
		END
		---
		IF NOT @inUserId IS NULL
		and @inUserId <> '0'
		BEGIN
				SET						@parInUSERId = @inUSERId
		END
		---
		IF NOT @InUGRPId IS NULL
		and @inUGRPId <> '0'
		BEGIN
				SET						@parInUGRPId = @inUGRPId
		END
		---
	END TRY
	---
	BEGIN CATCH
		---
		SELECT
			@parERROR_NUMBER		= ERROR_NUMBER()				-- int
			,@parERROR_SEVERITY		= ERROR_SEVERITY() 				-- int
			,@parERROR_STATE		= ERROR_STATE() 				-- int
			,@parERROR_PROCEDURE	= ERROR_PROCEDURE()				-- varchar(max)
			,@parERROR_LINE			= ERROR_LINE() 					-- varchar(max)
			,@parERROR_MESSAGE		= ERROR_MESSAGE()				-- varchar(max)
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5040				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [Fehler bei der ZuweISung der Variablen]'							+ '; '
		---
	END CATCH
END
---
-----------------------------------------------------------------------------------------*
---- PRÜFE OB BENUTZER VORHANDEN IST
-----------------------------------------------------------------------------------------*
IF @flag = 0
BEGIN
	BEGIN TRY
		---
		------------------------------------------
		--  BenutzerNamen prüfen ob vorhanden IST
		------------------------------------------
		SET @RESULT = 0
		SET @RESULT = (SELECT  COUNT(*) 
						FROM _USER
						WITH (NOLOCK)
						WHERE BenutzerName = @inBenutzerName)
		---------------------------------------------
		SET @RESULT = 0
		IF @RESULT > 0
		BEGIN
			PRINT 'ACHTUNG!!! BENUTZERNAME VORHANDEN!'
			SELECT * FROM _USER
			WITH(NOLOCK)
			WHERE  BenutzerName = @inBenutzerName
		END
		---
		------------------------------------------
		--  PRÜFE OB BENUTZERKENNUNG VORHANDEN IST
		------------------------------------------	
		SET @RESULT = 0
		SET @RESULT = (SELECT  COUNT(*)
						FROM _USER
						WITH (NOLOCK)
						WHERE BenutzerKennung = @inBenutzerKennung)
		---------------------------------------------
		SET @RESULT = 0
		IF @RESULT > 0
		BEGIN
			PRINT 'ACHTUNG!!! BENUTZERKENNUNG VORHANDEN!'
			SELECT  * FROM _USER
			WITH (NOLOCK)
			WHERE BenutzerKennung = @inBenutzerKennung
		END
		---
	END TRY
	---
	BEGIN CATCH
		---
		SELECT
			@parERROR_NUMBER		= ERROR_NUMBER()				-- int
			,@parERROR_SEVERITY		= ERROR_SEVERITY() 				-- int
			,@parERROR_STATE		= ERROR_STATE() 				-- int
			,@parERROR_PROCEDURE	= ERROR_PROCEDURE()				-- varchar(max)
			,@parERROR_LINE			= ERROR_LINE() 					-- varchar(max)
			,@parERROR_MESSAGE		= ERROR_MESSAGE()				-- varchar(max)
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5050				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [Fehler beim prüfen ob der Benutzer vorhanden ISt]]'							+ '; '
		---
	END CATCH
END
---
-----------------------------------------------------------------------------------------*
---- INSERT Benutzer in _USER
-----------------------------------------------------------------------------------------*	
IF @flag = 0
BEGIN
	BEGIN TRY
		SET @RESULT = 0
		---
		IF @RESULT = 0
		BEGIN
			PRINT 'Keine Übereinstimmung gefunden. Daten dürfen verwENDet werden.'
			-------------------------------------------
			PRINT '========================================================='     
			INSERT INTO _USER(BenutzerKennung, PassWort, BenutzerName, UserEmail, UserTelefon)       
			VALUES (@inBenutzerKennung, @inPassWort, @inBenutzerName,@inUserEMail,@inUserTelefon)                                                                                                                                                                                                                                                                                                                                                                                                                                  
			---
			-----------------------------
			--  ErgebnIS anzeigen 
			-----------------------------                                                                                                       
			SET @inUserId = (SELECT USERId FROM _USER WITH (NOLOCK) WHERE (USERId = @@IDENTITY))             
		END
		---
	END TRY
		---
	BEGIN CATCH
		---
		SELECT
			@parERROR_NUMBER		= ERROR_NUMBER()				-- int
			,@parERROR_SEVERITY		= ERROR_SEVERITY() 				-- int
			,@parERROR_STATE		= ERROR_STATE() 				-- int
			,@parERROR_PROCEDURE	= ERROR_PROCEDURE()				-- varchar(max)
			,@parERROR_LINE			= ERROR_LINE() 					-- varchar(max)
			,@parERROR_MESSAGE		= ERROR_MESSAGE()				-- varchar(max)
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5060				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [Fehler beim insert zur _USER tabelle ]]'							+ '; '
		---
	END CATCH
END		
---       
-----------------------------------------------------------------------------------------*
--- Befehl zum anlegen der Zuordnung von AnschrIFt zu Benutzer in _User2ANSF                                                              
--- hier die entsprechENDe AnschrIFten ID (_AnschriftenId) aus _Anschriften eingeben
-----------------------------------------------------------------------------------------*		
IF @flag = 0
BEGIN
	BEGIN TRY
		IF @inUGRPId <> '24'
		BEGIN
			INSERT INTO _User2ANSF(USERId, ANSFId)                                                                                
				VALUES (@inUSERId, @inANSFId);     
			-----------------------------
			--  ErgebnIS anzeigen 
			-----------------------------	
			  
			SELECT USERId, ANSFId 
			FROM _User2ANSF 
			WITH(NOLOCK)
			WHERE (USERId = @inUSERId)   
		END
		---
	END TRY
		---
	BEGIN CATCH
		---
		SELECT
			@parERROR_NUMBER		= ERROR_NUMBER()				-- int
			,@parERROR_SEVERITY		= ERROR_SEVERITY() 				-- int
			,@parERROR_STATE		= ERROR_STATE() 				-- int
			,@parERROR_PROCEDURE	= ERROR_PROCEDURE()				-- varchar(max)
			,@parERROR_LINE			= ERROR_LINE() 					-- varchar(max)
			,@parERROR_MESSAGE		= ERROR_MESSAGE()				-- varchar(max)
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5070				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [Fehler beim Befehl zum anlegen der Zuordnung von AnschrIFt zu Benutzer in _User2ANSF]]'							+ '; '
		---
	END CATCH
END	
--
-----------------------------------------------------------------------------------------*
-- Befehl zum anlegen der Zuordnung von AnschrIFt zu Benutzer in _USER2ANSF
-----------------------------------------------------------------------------------------*	
IF @flag = 0
BEGIN
	BEGIN TRY
		INSERT INTO _USER2UGRP(USERId, UGRPId)                                                                                     
			VALUES (@inUSERId, @inUGRPId);                                                                                                
        ---
		-----------------------------
		-- Berechtigunen1
		-----------------------------
		IF @inUGRPId = '24'
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId)
				VALUES (@inUSERId, '30')
			INSERT INTO _USER2UGRP(USERId, UGRPId)                                                                                  
				VALUES (@inUSERId, '32') 
			INSERT INTO _USER2UGRP(USERId, UGRPId)                                                                                  
				VALUES (@inUSERId, '33')
			INSERT INTO _USER2UGRP(USERId, UGRPId)                                                                                  
				VALUES (@inUSERId, '50')
		END
		---
		-----------------------------
		-- Berechtigunen2 
		-----------------------------
		IF @inUGRPId = '66' or @inUGRPId = '67'                                                                              
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId)                                                                                  
			VALUES (@inUSERId, '143')
		END
        ---
		-------------------------------------
		--Berechtigunen3   
		-------------------------------------
		IF @inUGRPId = '77'
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId)
			VALUES (@inUSERId, '101')
		END
		---
		----------------------------------------------------------
		---Berechtigunen4
		----------------------------------------------------------
		IF @inUGRPId = '236'
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId)
			VALUES (@inUserId, 236)
		END
		---
		-----------------------------
		---Berechtigunen5
		-----------------------------
		IF @inUGRPId = '369'
		BEGIN
			INSERT INTO _USER2UGRP(USERId, UGRPId)
			VALUES (@inUSERId, '373')
		END
		---
		-----------------------------
		---Berechtigunen6  
		-----------------------------
			SELECT USERId, UGRPId 
			FROM _USER2UGRP 
			WITH(NOLOCK) 
			WHERE (USERId = @inUSERId) 
		---
	END TRY
		---
	BEGIN CATCH
		---
		SELECT
			@parERROR_NUMBER		= ERROR_NUMBER()				-- int
			,@parERROR_SEVERITY		= ERROR_SEVERITY() 				-- int
			,@parERROR_STATE		= ERROR_STATE() 				-- int
			,@parERROR_PROCEDURE	= ERROR_PROCEDURE()				-- varchar(max)
			,@parERROR_LINE			= ERROR_LINE() 					-- varchar(max)
			,@parERROR_MESSAGE		= ERROR_MESSAGE()				-- varchar(max)
		---
		SET @flag				= @flag + 1024
		Set @outResult			= 5080				-- Farbe rot
		Set @outMeldung			= LTRIM(RTRIM(@outMeldung)) + 'A B B R U C H ! [Fehler beim Befehl zum anlegen der Zuordnung von AnschrIFt zu Benutzer in _USER2UGRP]]'							+ '; '
		---
	END CATCH
END	
---
-----------------------------------------------------------------------------------------*
-- Wenn keine Fehler aufgetreten sind grün
-----------------------------------------------------------------------------------------*
IF	@flag = 0
and @outResult = 0
BEGIN
	SET @outResult		= 10				-- Farbe grün
	SET @outMeldung		= LTRIM(RTRIM(@outMeldung))		+ 'E R F O L G ! [Metin_BenutzerGenerator planmäßig beENDet]' + '; '
END
---
Return(@flag)
