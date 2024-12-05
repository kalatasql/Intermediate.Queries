	WITH SumOfConfirmations AS 
		(
		SELECT transactionID, SUM(Amount) AS PaidAmount 
		FROM TransactionsConfirmations
		GROUP BY transactionID
		)

	SELECT CONVERT(DECIMAL(18, 2), AVG(st.PaidAmount)) AS AVG_PaidAmount_For_All_Tran  
	FROM Transactions t
	LEFT JOIN SumOfConfirmations st ON st.transactionID = t.TransactionId
