

![Logo](https://github.com/hamajid/Sales_DataBase_MySQL/blob/main/Media/HA_Logo.png) 

# Maven ToysData Analysis

Maven Toys is a fictitious chain of stores in Mexico.

### Disclaimer

The data set used for this project was downloaded from ( https://www.mavenanalytics.io/data-playground)

### Contents

[About Maven Toys Data](#about-Maven-Toys-Data)<br/>
[Explore the data ](#Explore-the-data)<br/>

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

1. Show all products
I added a "Profit" to know what is the most profitable item.
```
SELECT *, Product_Price-Product_Cost AS Profit FROM products
ORDER BY Profit DESC;
GO
```
![AllProd](https://github.com/hamajid/MavenToysDataAnalysis/blob/main/Media/AllProd.PNG) 

2. Check the inventory level


