CREATE TRIGGER T_STOCK_CONTROL_PRODUCT
ON BILL_DETAILS
FOR INSERT
AS
DECLARE @ID_PRODUCT INT 
SELECT @ID_PRODUCT = ID_PRODUCT FROM INSERTED
DECLARE @AMOUNT INT
SELECT @AMOUNT = AMOUNT FROM INSERTED
DECLARE @STOCK INT
SELECT @STOCK = STOCK FROM PRODUCTS WHERE ID = @ID_PRODUCT
IF (@AMOUNT <= @STOCK)
	BEGIN
		UPDATE PRODUCTS
		SET
		STOCK = STOCK - @AMOUNT
		WHERE ID = @ID_PRODUCT
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION
		PRINT 'No hay stock del artículo seleccionado'
	END
GO