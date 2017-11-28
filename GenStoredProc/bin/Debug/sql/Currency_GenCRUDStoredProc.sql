--GenCRUDStoredProc Template for Table : Currency
--GetAll
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CurrencyGetAll' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].CurrencyGetAll
GO
CREATE PROCEDURE [dbo].CurrencyGetAll
AS
	SET NOCOUNT ON;
SELECT * FROM  Currency
GO

--GetById
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CurrencyGetById' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].CurrencyGetById
GO
CREATE PROCEDURE [dbo].CurrencyGetById
(
	@CurrencyCode varchar(3)
)
AS
	SET NOCOUNT ON;
SELECT * FROM  Currency WHERE ([CurrencyCode] = @CurrencyCode)
GO


--INSERT
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CurrencyInsert' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].CurrencyInsert
GO
CREATE PROCEDURE [dbo].CurrencyInsert
(
	@CurrencyCode varchar(3),
@DisplayName varchar(50),
@Surcharge decimal(18,2),
@Discount decimal(18,2),
@ModifiedDate datetime,
@ModifiedBy varchar(50),
@CapturedDate datetime,
@CapturedBy varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO  [Currency]
([CurrencyCode],
[DisplayName],
[Surcharge],
[Discount],
[ModifiedDate],
[ModifiedBy],
[CapturedDate],
[CapturedBy])
VALUES 
(@CurrencyCode,
@DisplayName,
@Surcharge,
@Discount,
@ModifiedDate,
@ModifiedBy,
@CapturedDate,
@CapturedBy)
	
SELECT @@IDENTITY AS 'Identity';  
GO

--Update
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CurrencyUpdate' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].CurrencyUpdate
GO
CREATE PROCEDURE [dbo].CurrencyUpdate
(
	@CurrencyCode varchar(3),
@DisplayName varchar(50),
@Surcharge decimal(18,2),
@Discount decimal(18,2),
@ModifiedDate datetime,
@ModifiedBy varchar(50),
@CapturedDate datetime,
@CapturedBy varchar(50)
)
AS
	SET NOCOUNT OFF;
UPDATE [Currency] SET 
[CurrencyCode] = @CurrencyCode,
[DisplayName] = @DisplayName,
[Surcharge] = @Surcharge,
[Discount] = @Discount,
[ModifiedDate] = @ModifiedDate,
[ModifiedBy] = @ModifiedBy,
[CapturedDate] = @CapturedDate,
[CapturedBy] = @CapturedBy 
WHERE ([CurrencyCode] = @CurrencyCode);
	
SELECT * FROM Currency WHERE ([CurrencyCode] = @CurrencyCode)
GO


--Delete
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CurrencyDelete' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].CurrencyDelete
GO
CREATE PROCEDURE [dbo].CurrencyDelete
(
	@CurrencyCode varchar(3)
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Currency] WHERE ([CurrencyCode] = @CurrencyCode)
GO