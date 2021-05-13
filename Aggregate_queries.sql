--Lost Data Mart--
SELECT customer_dim.name,SUM(sales_fact.Qty) AS 'Total Sale' FROM dw_lab03.customer_dim
LEFT JOIN dw_lab03.sales_fact ON customer_dim.Customer_SK = sales_fact.Cust_SK
GROUP BY customer_dim.name
ORDER BY SUM(sales_fact.Qty) DESC;


SELECT product_dim.ProductName, SUM(sales_fact.Qty) AS 'Total Quantity', SUM(sales_fact.Sales_Amt) AS 'Total Quantity' FROM dw_lab03.product_dim
JOIN dw_lab03.sales_fact ON product_dim.Product_SK = sales_fact.Prod_SK
WHERE product_dim.ProductName = "Defeated Tray Supplies"
GROUP BY product_dim.ProductName;

--Shrunken Data Mart--
SELECT customer_dim.name, salesdate_dim.Year, SUM(sales_fact.Sales_Amt) AS 'Total Sales' FROM dw_lab03.customer_dim
INNER JOIN dw_lab03.sales_fact ON sales_fact.Cust_SK = customer_dim.Customer_SK
INNER JOIN dw_lab03.salesdate_dim ON sales_fact.SalesDate_SK = salesdate_dim.SalesDate_SK
WHERE customer_dim.name= 'Ann Lee'
GROUP BY customer_dim.name, salesdate_dim.Year;

SELECT sales_fact.`Sales By`,salesdate_dim.Year,SUM(sales_fact.Sales_Amt) AS 'Total Sales' FROM dw_lab03.customer_dim
INNER JOIN dw_lab03.sales_fact ON sales_fact.Cust_SK = customer_dim.Customer_SK
INNER JOIN dw_lab03.salesdate_dim ON sales_fact.SalesDate_SK = salesdate_dim.SalesDate_SK
GROUP BY sales_fact.`Sales By`,salesdate_dim.Year
ORDER BY sales_fact.`Sales By`;

--Collapsed Data Mart--
CREATE TABLE collapsed_fact(
CustomerName VARCHAR(45) DEFAULT NULL,
ProductName VARCHAR(45) DEFAULT NULL,
Year INT DEFAULT NULL,
Quantity INT DEFAULT null
);

INSERT INTO collapsed_fact
SELECT customer_dim.name, product_dim.ProductName, salesdate_dim.Year, SUM(sales_fact.Qty) 
FROM sales_fact
INNER JOIN customer_dim ON sales_fact.Cust_SK=customer_dim.Customer_SK 
INNER JOIN product_dim ON sales_fact.Prod_SK=product_dim.Product_SK 
INNER JOIN salesdate_dim ON sales_fact.SalesDate_SK=salesdate_dim.SalesDate_SK 
GROUP BY customer_dim.Name,product_dim.ProductName,salesdate_dim.Year;

SELECT collapsed_fact.ProductName,collapsed_fact.Year, collapsed_fact.Quantity FROM collapsed_fact
WHERE collapsed_fact.Quantity > 2000
ORDER BY collapsed_fact.Quantity DESC;

SELECT collapsed_fact.CustomerName, SUM(collapsed_fact.Quantity) FROM collapsed_fact
GROUP BY collapsed_fact.CustomerName
ORDER BY SUM(collapsed_fact.Quantity) DESC;