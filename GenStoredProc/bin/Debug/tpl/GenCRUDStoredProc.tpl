--GenCRUDStoredProc Template for Table : <<TableName>>
--GetAll
IF EXISTS (SELECT * FROM sysobjects WHERE name = '<<TableName>>GetAll' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].<<TableName>>GetAll
GO
CREATE PROCEDURE [dbo].<<TableName>>GetAll
AS
	SET NOCOUNT ON;
SELECT * FROM  <<TableName>>
GO

--GetById
IF EXISTS (SELECT * FROM sysobjects WHERE name = '<<TableName>>GetById' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].<<TableName>>GetById
GO
CREATE PROCEDURE [dbo].<<TableName>>GetById
(
	@<<KeyColunm>> <<KeyColunmType>>
)
AS
	SET NOCOUNT ON;
SELECT * FROM  <<TableName>> WHERE ([<<KeyColunm>>] = @<<KeyColunm>>)
GO


--INSERT
IF EXISTS (SELECT * FROM sysobjects WHERE name = '<<TableName>>Insert' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].<<TableName>>Insert
GO
CREATE PROCEDURE [dbo].<<TableName>>Insert
(
	<<ParamColunms>>
)
AS
	SET NOCOUNT OFF;
INSERT INTO  [<<TableName>>]
(<<InsertColunms>>)
VALUES 
(<<InsertValues>>)
	
SELECT @@IDENTITY AS 'Identity';  
GO

--Update
IF EXISTS (SELECT * FROM sysobjects WHERE name = '<<TableName>>Update' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].<<TableName>>Update
GO
CREATE PROCEDURE [dbo].<<TableName>>Update
(
	<<ParamColunms>>
)
AS
	SET NOCOUNT OFF;
UPDATE [<<TableName>>] SET 
<<UpdateColunms>> 
WHERE ([<<KeyColunm>>] = @<<KeyColunm>>);
	
SELECT * FROM <<TableName>> WHERE ([<<KeyColunm>>] = @<<KeyColunm>>)
GO


--Delete
IF EXISTS (SELECT * FROM sysobjects WHERE name = '<<TableName>>Delete' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].<<TableName>>Delete
GO
CREATE PROCEDURE [dbo].<<TableName>>Delete
(
	@<<KeyColunm>> <<KeyColunmType>>
)
AS
	SET NOCOUNT OFF;
DELETE FROM [<<TableName>>] WHERE ([<<KeyColunm>>] = @<<KeyColunm>>)
GO