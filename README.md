![Logo](https://github.com/hamajid/Sales_DataBase_MySQL/blob/main/Media/HA_Logo.png) 

# Maven Toys 

Maven Toys is a fictitious chain of stores in Mexico.

### Disclaimer

The data set used for this project was downloaded from ( https://www.mavenanalytics.io/data-playground)

### Contents

**[About Maven Toys Data](#about-Maven-Toys-Data)<br/>**
**[Exploring and Analyzing the data](#Explore-the-data)<br/>**
> ***[Products](#Products)<br/>***
> ***[Stores](#Stores)<br/>***
> ***[Inventory](#Inventory)<br/>***
> ***[Sales](#Sales)<br/>***

<a name=about-Maven-Toys-Data></a>
## About Maven Toys Data

The Maven Toys sales and inventory data include information about products, stores, daily sales transactions. and current inventory levels at each location.
The data set is composed of 4 CSV files:
- Products
- Stores
- Inventory
- Sales

Those files were loaded to the database using SQL Server Import and Export Data.

<a name=Explore-the-data></a>
## Exploring and Analyzing the data

<a name=Products></a>
>***Products.***


**1.Products by Cost.**
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price 
FROM products
ORDER BY Cost DESC;
```
![Prod_Cost](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Prod_Cost.PNG) 

**2.Products by Price.**
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price 
FROM products
ORDER BY Price DESC;
```
![Prod_Price](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Prod_Price.PNG).

**3.Calculate the gross profit by product.**
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price, Product_Price-Product_Cost AS Profit 
FROM products
ORDER BY Profit DESC;
```
![Prod_Profit](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Prod_Profit.PNG) 

**4. Calculate the Margin and Markup by product.**

The profit margin and the markup are calculated base on the profit:
Lets use **P** for the gross profit, **C** for cost, and **R** for revenue. 

**P for Profit**, **C for Cost**, **R for Revenue**, **M for Markup**, and **G for Margin**.

The formulas are

>**P=R-C** in our case is *Product_Price-Product_Cost*.

>**M=P/C=(R-C)/C** in our example is *(Product_Price-Product_Cost)/Product_Cost*.

>**G=P/R=(R-C)/R** in our example is *(Product_Price-Product_Cost)/Product_Price*
  
To express those values as a percentage, we must multiply the result by 100.

***4.1.Calculate the Markup.***
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price,
	(((Product_Price-Product_Cost)/Product_Cost)*100) AS [MarkUp in %]
FROM products
ORDER BY [MarkUp in %] Desc;
```
![MarkUp](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Markup.PNG) 

***4.2.Calculate the Margin.***
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price,
	(((Product_Price-Product_Cost)/Product_Price)*100) AS [Margin in %]
FROM products
ORDER BY  [Margin in %] DESC;
```
![Margin](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Margin.PNG) 

<a name=Stores></a>
> ***Stores.***

**1.Number of Stores.**

Lets check how many stores does the company have.
```
SELECT COUNT(Store_Name) AS [Total number of Stores]
FROM STORES;
```
![TotalStores](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/T_Stores.PNG)

**2.Store Cities and Type .**

I would like to know where the stores are located and how many store in each City.
```
SELECT Store_City AS City, COUNT(Store_Name) AS [Total number of Stores]
FROM STORES
Group by Store_City
Order By [Total number of Stores] DESC;
```
![Stores_City](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Stores_City.PNG)

Filter the stores by City and Type.
```
SELECT Store_City AS City, Store_Location,  COUNT(Store_Name) AS [Total number of Stores]
FROM STORES
Group by Store_City, Store_Location
Order By City DESC;
```
![Stores_City_Loc](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Stores_City_Loc.PNG)

From the result, I noticed that cities don't have the same type of store twice ( Example: Cuidad de Mexico has 4 stores and none of them is in the same type as others).

**3. Store Age.**

In the following query, we will use the date dif function to calculate the difference between the Store_Open_Date and today (01/07/2022). Knowing the age it's an important element to understand its performance.

```
SELECT  Store_Name AS Name, Store_City AS City, Store_Location AS [Type], (DATEDIFF (Day, Store_Open_Date, GETDATE())) As  [Age in Days],
Round (((DATEDIFF (DAY, Store_Open_Date, GETDATE())/365)),0) As [Years], 
Round(((DATEDIFF (DAY, Store_Open_Date, GETDATE())%365)/30),0) As [Months],
Round(((DATEDIFF (DAY, Store_Open_Date, GETDATE())%365)%30),0) As [Days]
FROM STORES
Order By [Years] DESC;
```
![Stores_Age](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Stores_Age.PNG)

<a name=Inventory></a>
>***Inventory.***

The inventory cost by product

```
SELECT P.Product_Name AS [Product Name], SUM(I.Stock_On_Hand) AS [Available Quantity], SUM(I.Stock_On_Hand * Product_Cost) AS [Inv Cost]
FROM Inventory AS I
INNER JOIN Products AS P
ON
P.Product_ID = I.Product_ID 
GROUP BY Product_Name
ORDER BY [Available Quantity] ;
```
![Inv_Cost_Prd](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Inv_Cost_Prd.PNG)

The inventory cost by Store

```
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
```
![Inv_Cost_Str](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Inv_Cost_Str.PNG)


The inventory cost by Store and Product

```
SELECT S.Store_Name AS [Store], P.Product_Name AS [Product Name],  I.Stock_On_Hand AS [Available Quantity], (I.Stock_On_Hand * Product_Cost) AS [Inv Cost]
FROM Stores AS S
INNER JOIN Inventory AS I
ON
S.Store_ID = I.Store_ID 
INNER JOIN Products AS P
ON
P.Product_ID = I.Product_ID 
ORDER BY [Store], [Available Quantity] DESC ;
```
![Inv_Cost_Prd_Str](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Inv_Cost_Prd_Str.PNG)

<a name=Sales></a>
>***Sales.***

To make it easy and simple, I created a view and I joined related tables for a better I/O management. 
```
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


**1.Total Revenue, Cost and Profit.**

```
Select  FORMAT(ROUND((SUM ([Order Price]))/1000000,2),'C') AS [Total Revenue In Million], 
		FORMAT(ROUND((SUM ([Order Cost]))/1000000,2), 'C') AS [Total Cost In Million], 
		FORMAT(ROUND((SUM ([Net Profit]))/1000000,2), 'C') AS [Total Profit In Million],
		ROUND(((SUM ([Order Price])-SUM([Order Cost]))/Sum([Order Price])*100),2) AS [Profit Margin In Percentage]
from v_Order;
```
![Order_Rev](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Order_Rev.PNG)
