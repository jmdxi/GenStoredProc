--GenCRUDStoredProc Template for Table : ExchangeRate
--GetAll
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ExchangeRateGetAll' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].ExchangeRateGetAll
GO
CREATE PROCEDURE [dbo].ExchangeRateGetAll
AS
	SET NOCOUNT ON;
SELECT * FROM  ExchangeRate
GO

--GetById
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ExchangeRateGetById' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].ExchangeRateGetById
GO
CREATE PROCEDURE [dbo].ExchangeRateGetById
(
	@ExchangeId int
)
AS
	SET NOCOUNT ON;
SELECT * FROM  ExchangeRate WHERE ([ExchangeId] = @ExchangeId)
GO


--INSERT
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ExchangeRateInsert' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].ExchangeRateInsert
GO
CREATE PROCEDURE [dbo].ExchangeRateInsert
(
	
@CurrencyCode varchar(3),
@Rate numeric(18,6),
@CapturedDate datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO  [ExchangeRate]
(
[CurrencyCode],
[Rate],
[CapturedDate])
VALUES 
(
@CurrencyCode,
@Rate,
@CapturedDate)
	
SELECT @@IDENTITY AS 'Identity';  
GO

--Update
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ExchangeRateUpdate' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].ExchangeRateUpdate
GO
CREATE PROCEDURE [dbo].ExchangeRateUpdate
(
	@ExchangeId int,
@CurrencyCode varchar(3),
@Rate numeric(18,6),
@CapturedDate datetime
)
AS
	SET NOCOUNT OFF;
UPDATE [ExchangeRate] SET 

[CurrencyCode] = @CurrencyCode,
[Rate] = @Rate,
[CapturedDate] = @CapturedDate 
WHERE ([ExchangeId] = @ExchangeId);
	
SELECT * FROM ExchangeRate WHERE ([ExchangeId] = @ExchangeId)
GO


--Delete
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ExchangeRateDelete' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].ExchangeRateDelete
GO
CREATE PROCEDURE [dbo].ExchangeRateDelete
(
	@ExchangeId int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [ExchangeRate] WHERE ([ExchangeId] = @ExchangeId)
GO