-- Two ways to get transactions Paid Status from the table with transactions and the table with TransactionsConfirmations 

1. With CTE

		WITH 
		TConf AS (
			SELECT TransactionID, SUM(Amount) AS SumOFAmount
			FROM TransactionsConfirmations
			GROUP BY TransactionID
		)
		SELECT t.TransactionId, t.AccountId, t.TranDate, t.Amount, ISNULL(tc.SumOFAmount, 0) AS [PaidAmount], 
		CASE 
		    WHEN ISNULL(tc.SumOFAmount, 0) = 0 THEN 'No Confirmations'
			WHEN Amount = ISNULL(tc.SumOFAmount, 0) THEN 'Completed'
			WHEN Amount > ISNULL(tc.SumOFAmount, 0) THEN 'Pending'
			else 'OverPaid'
		END AS [Tran Status]
		FROM Transactions t
		LEFT JOIN TConf tc ON t.TransactionId = tc.transactionid

2. With SubQuery 

		SELECT t.TransactionId, t.AccountId, t.TranDate, t.Amount, ISNULL(tc.SumOFAmount, 0) AS [PaidAmount], 
		CASE 
		    WHEN ISNULL(tc.SumOFAmount, 0) = 0 THEN 'No Confirmations'
			WHEN Amount = ISNULL(tc.SumOFAmount, 0) THEN 'Completed'
			WHEN Amount > ISNULL(tc.SumOFAmount, 0) THEN 'Pending'
			else 'OverPaid'
		END AS [Tran Status]
		FROM Transactions t
		LEFT JOIN (SELECT TransactionID, SUM(Amount) AS SumOFAmount
			FROM TransactionsConfirmations
			GROUP BY TransactionID) as tc ON t.transactionID = tc.TransactionID
