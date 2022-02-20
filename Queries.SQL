--Products by Cost.
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price 
FROM products
ORDER BY Cost DESC;

--Products by Price.
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price 
FROM products
ORDER BY Price DESC;

--Calculate the gross profit by product.
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price, Product_Price-Product_Cost AS Profit 
FROM products
ORDER BY Profit DESC;

--Calculate the Markup.
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price,
	(((Product_Price-Product_Cost)/Product_Cost)*100) AS [MarkUp in %]
FROM products
ORDER BY [MarkUp in %] Desc;

--Calculate the Margin.
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price,
	(((Product_Price-Product_Cost)/Product_Price)*100) AS [Margin in %]
FROM products
ORDER BY  [Margin in %] DESC;

--Number of Stores.
SELECT COUNT(Store_Name) AS [Total number of Stores]
FROM STORES;

--Store Cities and Type .
SELECT Store_City AS City, COUNT(Store_Name) AS [Total number of Stores]
FROM STORES
Group by Store_City
Order By [Total number of Stores] DESC;

--Filter the stores by City and Type.
SELECT Store_City AS City, Store_Location,  COUNT(Store_Name) AS [Total number of Stores]
FROM STORES
Group by Store_City, Store_Location
Order By City DESC;

--Store Age.
SELECT  Store_Name AS Name, Store_City AS City, Store_Location AS [Type], (DATEDIFF (Day, Store_Open_Date, GETDATE())) As  [Age in Days],
Round (((DATEDIFF (DAY, Store_Open_Date, GETDATE())/365)),0) As [Years], 
Round(((DATEDIFF (DAY, Store_Open_Date, GETDATE())%365)/30),0) As [Months],
Round(((DATEDIFF (DAY, Store_Open_Date, GETDATE())%365)%30),0) As [Days]
FROM STORES
Order By [Years] DESC;

--The inventory cost by product
SELECT P.Product_Name AS [Product Name], SUM(I.Stock_On_Hand) AS [Available Quantity], SUM(I.Stock_On_Hand * Product_Cost) AS [Inv Cost]
FROM Inventory AS I
INNER JOIN Products AS P
ON
P.Product_ID = I.Product_ID 
GROUP BY Product_Name
ORDER BY [Available Quantity] ;

--The inventory cost by Store
SELECT S.Store_Name AS [Store], SUM(I.Stock_On_Hand) AS [Available Quantity], SUM(I.Stock_On_Hand * Product_Cost) AS [Inv Cost]
FROM Stores AS S
INNER JOIN Inventory AS I
ON
S.Store_ID = I.Store_ID 
INNER JOIN Products AS P
ON
P.Product_ID = I.Product_ID 
GROUP BY Store_Name
ORDER BY [Available Quantity] ;

The inventory cost by Store and Product
SELECT S.Store_Name AS [Store], P.Product_Name AS [Product Name],  I.Stock_On_Hand AS [Available Quantity], (I.Stock_On_Hand * Product_Cost) AS [Inv Cost]
FROM Stores AS S
INNER JOIN Inventory AS I
ON
S.Store_ID = I.Store_ID 
INNER JOIN Products AS P
ON
P.Product_ID = I.Product_ID 
ORDER BY [Store], [Available Quantity] DESC ;

--Sales View .
Create VIEW v_Order AS 
SELECT 
	Sale_ID AS [Order #], Date AS [Order Date], Units AS [Quantity], Store_Name AS [Store Name], Store_City AS City, Store_Location AS [Store Type],
	Product_Name AS Product, Product_Category AS Category, Product_Cost * Units AS [Order Cost], Product_Price * Units AS [Order Price], (Product_Price-Product_Cost)*units AS [Net Profit]
FROM Sales AS O 
INNER JOIN Products AS P
ON
O.Product_ID = P.Product_ID
INNER JOIN Stores AS S
ON
O.Store_ID = S.Store_ID;

--Total Revenue, Cost and Profit.
Select  
FORMAT(ROUND((SUM ([Order Price]))/1000000,2),'C') AS [Total Revenue In Million], 
FORMAT(ROUND((SUM ([Order Cost]))/1000000,2), 'C') AS [Total Cost In Million], 
FORMAT(ROUND((SUM ([Net Profit]))/1000000,2), 'C') AS [Total Profit In Million],
ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order;

--Total Revenue, Cost, Quantity and Profit.
Select  
FORMAT(ROUND((SUM ([Order Price]))/1000000,2),'C') AS [Total Revenue In Million], 
FORMAT(ROUND((SUM ([Order Cost]))/1000000,2), 'C') AS [Total Cost In Million], 
ROUND((SUM ([Quantity]))/1000000,2) AS [Total Quantity Sold In Million],
FORMAT(ROUND((SUM ([Net Profit]))/1000000,2), 'C') AS [Total Profit In Million],
ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order;

--Total Revenue, Cost, Quantity and Profit by Product.
Select 
		Product,
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand],
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand],
		ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order
GROUP By Product
Order by [Total Profit In Thousand]DESC;

--Total Revenue, Cost, Quantity and Profit by Product Category.
Select 
		Category,
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand],
		ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order
GROUP By Category
Order by [Total Profit In Thousand]DESC;

--Revenue, Cost, Quantity and Profit by Store.
Select 
		[Store Name],
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand],
		ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order
GROUP By [Store Name]
Order by [Total Profit In Thousand]DESC;

--Total Revenue, Cost, Quantity and Profit by Store Type.
Select 
		[Store Type],
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand],
		ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order
GROUP By [Store Type]
Order by [Total Profit In Thousand]DESC;

--Total Revenue, Cost, Quantity and Profit by City.
Select 
		City,
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand],
		ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order
GROUP By City
Order by [Total Profit In Thousand]DESC;

--Sales Year to Year Comparaison .
--Total Revenue, Cost, Quantity and Profit by Year.
Select 
		Year([Order Date]) AS [Year],
		ROUND((SUM ([Order Price]))/1000000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000000,2) AS [Total Cost In Thousand],
		ROUND((SUM ([Quantity]))/1000000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand],
		ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order
GROUP By Year([Order Date])
Order by [Total Profit In Thousand]DESC;

--Total Revenue, Cost, Quantity and Profit by Product by year.
Select  Product,Year([Order Date])AS [Year],
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand]
		
from v_Order
GROUP By Year([Order Date]), Product
Order by Product, Year([Order Date]),[Total Profit In Thousand]DESC;

--Total Revenue, Cost, Quantity and Profit by Product Category.
Select  Category, Year([Order Date])AS [Year],
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand]				
from v_Order
GROUP By Year([Order Date]), Category
Order by Category, Year([Order Date]),[Total Profit In Thousand]DESC;

--Revenue, Cost, Quantity and Profit by Store by Year.
Select  [Store Name], Year([Order Date])AS [Year],
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand]				
from v_Order
GROUP By Year([Order Date]), [Store Name]
Order by [Store Name], Year([Order Date]),[Total Profit In Thousand]DESC;

--Total Revenue, Cost, Quantity and Profit by Store Type by Year.
Select  [Store Type],Year([Order Date])AS [Year],
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand]				
from v_Order
GROUP By Year([Order Date]), [Store Type]
Order by [Store Type], Year([Order Date]),[Total Profit In Thousand]DESC;

--Total Revenue, Cost, Quantity and Profit by City by Year.
Select  City,Year([Order Date])AS [Year],
		ROUND((SUM ([Order Price]))/1000,2) AS [Total Revenue In Thousand], 
		ROUND((SUM ([Order Cost]))/1000,2) AS [Total Cost In Thousand], 
		ROUND((SUM ([Quantity]))/1000,2) AS [Total Quantity Sold In Thousand],
		ROUND((SUM ([Net Profit]))/1000,2) AS [Total Profit In Thousand]				
from v_Order
GROUP By Year([Order Date]), City
Order by City, Year([Order Date]),[Total Profit In Thousand]DESC;
