Intermediate SQL Tasks:

1. Calculate the total order quantity for each order, including pending quantities.
2. Calculate the total delivered quantity and the pending quantity for each order.
3. Get the total order quantity for each material.
4. Update the pending quantity of an order when a delivery is made.
5. Find the average delivery time for all orders.
6. List all the orders that are overdue (where delivery date is in the past but not yet delivered).
7. Get the total quantity ordered and delivered for each vendor.
8. Find the most recent order for each material.

1. SELECT PurchasingOrder, 
	        SUM([ORDER QTY]) + SUM([PENDING QTY]) AS [SUM OF ORDER QTY AND PENDING QTY]
	 FROM OpenOrders 
	 GROUP BY PurchasingOrder

2. SELECT PurchasingOrder, 
	        SUM([Delivered QTY]) + SUM([Pending QTY]) AS [SUM OF Delivery QTY and Pending QTY]
	 FROM OpenOrders 
	 GROUP BY PurchasingOrder

3. SELECT SUM([Order QTY]) AS [Total Order QTY for Material],
	        Material
	 FROM OpenOrders
	 GROUP BY Material 

4. -- ALL DELIVERED Orders
   SELECT * 
   FROM OpenOrders 
   WHERE [Delivery Date] < GETDATE()
  -- Update
   UPDATE OpenOrders 
   SET [Delivered QTY] = [Delivered QTY] + [Pending QTY], 
	     [Pending QTY] = [Order QTY] - [Delivered QTY]
   WHERE [Delivery Date] < GETDATE()

5. SELECT AVG(DATEDIFF(DAY, [CREATE DATE], [DELIVERY DATE])) 
	        AS [AVERAGE DAYS FOR DELIVERY]
   FROM OpenOrders

6. SELECT *
   FROM OpenOrders 
   WHERE [Delivery Date] < GETDATE() AND [Pending QTY] > 0

7. --7. Get the total quantity ordered and delivered for each vendor.

SELECT Vendor, 
	   SUM([Order QTY]) AS [Total Order QTY for Vendor],
	   SUM([Delivered QTY]) AS [Total Delivered QTY for Vendor]
FROM OpenOrders 
GROUP BY Vendor 

SELECT Vendor, 
	   SUM([Order QTY]) + SUM([Delivered QTY]) AS [Total Order QTY And Delivered QTY for Vendor]
FROM OpenOrders 
GROUP BY Vendor 

8. SELECT rcntCrtDt.[MATERIAL], rcntCrtDt.[CREATE DATE] AS [RECENT ORDER DATE]
   FROM
   (SELECT 
	  ROW_NUMBER() OVER(PARTITION BY Material 
						ORDER BY [CREATE DATE] DESC) AS RowNum,
	  MATERIAL,
	  [CREATE DATE]
    FROM OpenOrders 
    ) rcntCrtDt
    WHERE RowNum = 1 

