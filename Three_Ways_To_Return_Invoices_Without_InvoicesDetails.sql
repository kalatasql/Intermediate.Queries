	SELECT inv.* -- Show all columns 
	FROM invoices inv -- From table invoices
	LEFT JOIN InvoicesDetails invD ON inv.ID = invD.invoice_Id -- Join the invoices with InvoicesDetails based on invoice_ID
	-- The LEFT JOIN ensures all records from invoices are included, even if there is no matching record in InvoicesDetails
	WHERE invD.invoice_Id IS NULL; -- This means there is no matching Invoice_ID in the InvoicesDetails for the current Invoice_ID in the Invoices table.


  SELECT *
  FROM
  invoices inv
  WHERE NOT EXISTS
  ( 
  SELECT 
	  1
  FROM InvoicesDetails invD 
  WHERE invD.Invoice_ID = inv.ID 
  )

  SELECT *
  FROM
  invoices inv
  WHERE id NOT IN
  ( 
    SELECT 
	  invD.invoice_Id
  FROM InvoicesDetails invD 
  WHERE invD.Invoice_ID = inv.ID 
)
