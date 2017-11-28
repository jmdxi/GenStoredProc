--GenCRUDStoredProc Template for Table : PurchaseOrder
--GetAll
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'PurchaseOrderGetAll' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].PurchaseOrderGetAll
GO
CREATE PROCEDURE [dbo].PurchaseOrderGetAll
AS
	SET NOCOUNT ON;
SELECT * FROM  PurchaseOrder
GO

--GetById
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'PurchaseOrderGetById' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].PurchaseOrderGetById
GO
CREATE PROCEDURE [dbo].PurchaseOrderGetById
(
	@OrderId int
)
AS
	SET NOCOUNT ON;
SELECT * FROM  PurchaseOrder WHERE ([OrderId] = @OrderId)
GO


--INSERT
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'PurchaseOrderInsert' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].PurchaseOrderInsert
GO
CREATE PROCEDURE [dbo].PurchaseOrderInsert
(
	
@CurrencyCode varchar(3),
@Rate decimal(18,6),
@Surcharge decimal(3,2),
@Discount decimal(3,2),
@ForeignAmount decimal(18,2),
@LocalAmount numeric(18,2),
@SurchargeAmount numeric(18,2),
@DiscountAmount numeric(18,2),
@CapturedDate datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO  [PurchaseOrder]
(
[CurrencyCode],
[Rate],
[Surcharge],
[Discount],
[ForeignAmount],
[LocalAmount],
[SurchargeAmount],
[DiscountAmount],
[CapturedDate])
VALUES 
(
@CurrencyCode,
@Rate,
@Surcharge,
@Discount,
@ForeignAmount,
@LocalAmount,
@SurchargeAmount,
@DiscountAmount,
@CapturedDate)
	
SELECT @@IDENTITY AS 'Identity';  
GO

--Update
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'PurchaseOrderUpdate' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].PurchaseOrderUpdate
GO
CREATE PROCEDURE [dbo].PurchaseOrderUpdate
(
	@OrderId int,
@CurrencyCode varchar(3),
@Rate decimal(18,6),
@Surcharge decimal(3,2),
@Discount decimal(3,2),
@ForeignAmount decimal(18,2),
@LocalAmount numeric(18,2),
@SurchargeAmount numeric(18,2),
@DiscountAmount numeric(18,2),
@CapturedDate datetime
)
AS
	SET NOCOUNT OFF;
UPDATE [PurchaseOrder] SET 

[CurrencyCode] = @CurrencyCode,
[Rate] = @Rate,
[Surcharge] = @Surcharge,
[Discount] = @Discount,
[ForeignAmount] = @ForeignAmount,
[LocalAmount] = @LocalAmount,
[SurchargeAmount] = @SurchargeAmount,
[DiscountAmount] = @DiscountAmount,
[CapturedDate] = @CapturedDate 
WHERE ([OrderId] = @OrderId);
	
SELECT * FROM PurchaseOrder WHERE ([OrderId] = @OrderId)
GO


--Delete
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'PurchaseOrderDelete' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].PurchaseOrderDelete
GO
CREATE PROCEDURE [dbo].PurchaseOrderDelete
(
	@OrderId int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [PurchaseOrder] WHERE ([OrderId] = @OrderId)
GO