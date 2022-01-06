![Logo](https://github.com/hamajid/Sales_DataBase_MySQL/blob/main/Media/HA_Logo.png) 

# Maven Toys 

Maven Toys is a fictitious chain of stores in Mexico.

### Disclaimer

The data set used for this project was downloaded from ( https://www.mavenanalytics.io/data-playground)

### Contents

[About Maven Toys Data](#about-Maven-Toys-Data)<br/>
[Explore the data ](#Explore-the-data)<br/>
[Create tables ](#Create-tables)<br/>
[Manipulating database](#Manipulating)<br/>
[Querying and exploring the database](#Querying)<br/>
[Subquery](#Subquery)<br/>

<a name=about-Maven-Toys-Data></a>
## About Maven Toys Data

The Maven Toys sales and inventory data include information about products, stores, daily sales transactions. and current inventory levels at each location.
The data set is composed of 4 CSV files:
- Inventory
- Products
- Sales
- Stores
Those files were loaded to the database using SQL Server Import and Export Data.

<a name=Explore-the-data></a>
## Explore the data

1. products Analysis.

- Sort products by Cost
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price 
FROM products
ORDER BY Cost DESC;
```
![Prod_Cost](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Prod_Cost.PNG) 
- Sort products by Price
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price 
FROM products
ORDER BY Price DESC;
```
![Prod_Price](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Prod_Price.PNG).
- Calculated and sort products by profit.
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price, Product_Price-Product_Cost AS Profit 
FROM products
ORDER BY Profit DESC;
```
![Prod_Profit](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Prod_Profit.PNG) 

2. Calculate the Margin and Markup by product.

The profit margin and the markup are calculated base on the profit:
Lets use **P** for the gross profit, **C** for cost, and **R** for revenue. 
`**P for Profit**, **C for Cost**, **R for Revenue**, **M for Markup**, and **G for Margin**.`
The formulas are:
>`**P=R-C** in our case is *Product_Price-Product_Cost*.`
>`**M=P/C=(R-C)/C** in our example is *(Product_Price-Product_Cost)/Product_Cost*.`
>`**G=P/R=(R-C)/R** in our example is *(Product_Price-Product_Cost)/Product_Price*.`
  
To express those values as a percentage, we must multiply the result by 100.
**Calculate the Markup.**
___
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price,
	(((Product_Price-Product_Cost)/Product_Cost)*100) AS [MarkUp in %]
FROM products
ORDER BY [MarkUp in %] Desc;
```
![MarkUp](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Markup.PNG) 
**Calculate the Margin.**
___
```
SELECT Product_Name AS Product, Product_Category AS Category, Product_Cost AS Cost, Product_Price AS Price,
	(((Product_Price-Product_Cost)/Product_Price)*100) AS [Margin in %]
FROM products
ORDER BY  [Margin in %] DESC;
```
![Margin](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/Margin.PNG) 

