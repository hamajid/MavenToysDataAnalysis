

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

1. Show all products
```
SELECT * FROM products;
GO
```
![AllProd](https://github.com/hamajid/Sales_DataBase_MySQL/blob/main/Media/AllProd.PNG)# MavenToysDataAnalysis
