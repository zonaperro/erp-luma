delimiter GO
DROP PROCEDURE IF EXISTS ProductHistorySummary
GO

create procedure ProductHistorySummary(IN lProductID bigint(20))
BEGIN
	/*******************************   
	Just set the value of
		@ProductID to check if Qty is 
		correct base don history
	*******************************/
	SET @ProductID = lProductID;

	SET @tblTransactions01Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems01  a
	INNER JOIN tblTransactions01  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions01);

	SET @tblTransactions02Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems02  a
	INNER JOIN tblTransactions02  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions02);

	SET @tblTransactions03Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems03  a
	INNER JOIN tblTransactions03  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions03);

	SET @tblTransactions04Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems04  a
	INNER JOIN tblTransactions04  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions04);

	SET @tblTransactions05Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems05  a
	INNER JOIN tblTransactions05  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions05);

	SET @tblTransactions06Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems06  a
	INNER JOIN tblTransactions06  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions06);

	SET @tblTransactions07Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems07  a
	INNER JOIN tblTransactions07  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions07);

	SET @tblTransactions08Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems08  a
	INNER JOIN tblTransactions08  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions08);

	SET @tblTransactions09Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems09  a
	INNER JOIN tblTransactions09  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions09);

	SET @tblTransactions10Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems10  a
	INNER JOIN tblTransactions10  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions10);

	SET @tblTransactions11Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems11  a
	INNER JOIN tblTransactions11  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions11);

	SET @tblTransactions12Qty = (SELECT SUM(Quantity) FROM
	(SELECT
		CASE TransactionItemStatus
			WHEN 0 THEN -Quantity
			WHEN 1 THEN 0
			WHEN 2 THEN 0
			WHEN 3 THEN Quantity
			WHEN 4 THEN -Quantity
		END AS Quantity
	FROM  tblTransactionItems12  a
	INNER JOIN tblTransactions12  b ON a.TransactionID = b.TransactionID
	WHERE 1=1 and productid = @ProductID) AS tblTransactions12);

	SET @tblStockItemsQty = (select sum(Quantity) FROM 
	(SELECT
		CASE StockDirection
			WHEN 0 THEN a.Quantity
			WHEN 1 THEN -a.Quantity
		END AS Quantity
	FROM (((tblStockItems a
	INNER JOIN tblStock f ON a.StockID = f.StockID
	LEFT OUTER JOIN tblProducts b ON a.ProductID = b.ProductID)
	LEFT OUTER JOIN tblProductBaseVariationsMatrix c ON a.VariationMatrixID = c.MatrixID)
	LEFT OUTER JOIN tblUnit d ON a.ProductUnitID = d.UnitID)
	LEFT OUTER JOIN tblStockType e ON a.StockTypeID = e.StockTypeID
	WHERE 1=1 and a.productid = @ProductID) AS tblStockItems);

	/**Set the value of Quantit to ZERO if null to prevent error*****/
	SET @tblTransactions01Qty = (SELECT IFNULL(@tblTransactions01Qty,0));
	SET @tblTransactions02Qty = (SELECT IFNULL(@tblTransactions02Qty,0));
	SET @tblTransactions03Qty = (SELECT IFNULL(@tblTransactions03Qty,0));
	SET @tblTransactions04Qty = (SELECT IFNULL(@tblTransactions04Qty,0));
	SET @tblTransactions05Qty = (SELECT IFNULL(@tblTransactions05Qty,0));
	SET @tblTransactions06Qty = (SELECT IFNULL(@tblTransactions06Qty,0));
	SET @tblTransactions07Qty = (SELECT IFNULL(@tblTransactions07Qty,0));
	SET @tblTransactions08Qty = (SELECT IFNULL(@tblTransactions08Qty,0));
	SET @tblTransactions09Qty = (SELECT IFNULL(@tblTransactions09Qty,0));
	SET @tblTransactions10Qty = (SELECT IFNULL(@tblTransactions10Qty,0));
	SET @tblTransactions11Qty = (SELECT IFNULL(@tblTransactions11Qty,0));
	SET @tblTransactions12Qty = (SELECT IFNULL(@tblTransactions12Qty,0));
	SET @tblStockItemsQty = (SELECT IFNULL(@tblStockItemsQty,0));

	SET @HistoryQty = (SELECT @tblTransactions01Qty + @tblTransactions02Qty + @tblTransactions03Qty + @tblTransactions04Qty + @tblTransactions05Qty + @tblTransactions06Qty +
		   @tblTransactions07Qty + @tblTransactions08Qty + @tblTransactions09Qty + @tblTransactions10Qty + @tblTransactions11Qty + @tblTransactions12Qty +
		   @tblStockItemsQty);

	SET @ProductQty = (SELECT quantity from tblproducts where productid = @ProductID);

	/*
	SELECT @tblTransactions01Qty;
	SELECT @tblTransactions02Qty;
	SELECT @tblTransactions03Qty;
	SELECT @tblTransactions04Qty;
	SELECT @tblTransactions05Qty;
	SELECT @tblTransactions06Qty;
	SELECT @tblTransactions07Qty;
	SELECT @tblTransactions08Qty;
	SELECT @tblTransactions09Qty;
	SELECT @tblTransactions10Qty;
	SELECT @tblTransactions11Qty;
	SELECT @tblTransactions12Qty;
	SELECT @tblStockItemsQty;
	*/

	select @ProductID AS ProductID, ProductDesc, @ProductQty AS ProductQty, @HistoryQty AS HistoryQty FROM tblProducts WHERE ProductID = @ProductID;

END;
GO

delimiter ;
delimiter ;


SELECT DateLastInitialized FROM tblTerminalReportHistory WHERE TerminalNo = '01' 
AND DATE_FORMAT(DateLastInitialized, '%Y-%m-%d %H:%i') >= DATE_FORMAT('2008-12-28 00:00', '%Y-%m-%d %H:%i') 
AND DATE_FORMAT(DateLastInitialized, '%Y-%m-%d %H:%i') <= DATE_FORMAT('2009-12-28 00:00', '%Y-%m-%d %H:%i') 
ORDER BY DateLastInitialized DESC;
