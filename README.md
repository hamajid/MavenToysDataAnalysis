![Logo](https://github.com/hamajid/Sales_DataBase_MySQL/blob/main/Media/HA_Logo.png) 

# Maven Toys 

Maven Toys is a fictitious chain of stores in Mexico.

### Disclaimer

The data set used for this project was downloaded from ( https://www.mavenanalytics.io/data-playground)

### Contents

**[About Maven Toys Data](#about-Maven-Toys-Data)<br/>**
**[Exploring the data](#Explore-the-data)<br/>**
> ***[Products](#Products)<br/>***
> ***[Stores](#Stores)<br/>***

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
## Exploring the data

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

Lets check the available quatity of each product

```
SELECT P.Product_Name AS [Product Name], COUNT(I.Stock_On_Hand) AS [Available Quantity]
FROM Inventory AS I, Stores AS S, Products AS P
WHERE
P.Product_ID = I.Product_ID 
GROUP BY Product_Name
ORDER BY [Available Quantity] ;
```
![T_InvByPrd] (https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/T_InvByPrd.PNG)

Lets check the available quatity of each product for every store


```
SELECT S.Store_Name AS [Store], P.Product_Name AS [Product Name],  I.Stock_On_Hand AS [Available Quantity]
FROM Inventory AS I, Stores AS S, Products AS P
WHERE
P.Product_ID = I.Product_ID AND
S.Store_ID = I.Store_ID
ORDER BY [Store], [Available Quantity] ;
```

![T_InvByStore] (https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/T_InvByStore.PNG)

