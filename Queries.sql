--Query 1--
CREATE INDEX CD
ON customer_dim(name);

SELECT customer_dim.name AS 'Customer Name', SUM(sales_fact.Sales_Amt) AS 'Sales' FROM dw_lab03.sales_fact
JOIN dw_lab03.customer_dim USE INDEX(CD) ON customer_dim.Customer_SK = sales_fact.Cust_SK
GROUP BY customer_dim.name
ORDER BY SUM(sales_fact.Sales_Amt) DESC;

--Query 2--
CREATE INDEX CT
ON customer_dim(TYPENAME);


SELECT customer_dim.TYPENAME,salesdate_dim.Year,salesdate_dim.Quarter,salesdate_dim.Month, SUM(sales_fact.Sales_Amt) AS 'Sales', SUM(sales_fact.UnitCost) AS 'Unit Cost' FROM dw_lab03.sales_fact
JOIN dw_lab03.customer_dim USE INDEX(CT) ON customer_dim.Customer_SK = sales_fact.Cust_SK
JOIN dw_lab03.salesdate_dim ON salesdate_dim.SalesDate_SK = sales_fact.SalesDate_SK
GROUP BY customer_dim.TYPENAME,salesdate_dim.Year,salesdate_dim.Quarter,salesdate_dim.Month
ORDER BY customer_dim.TYPENAME;

--Query 3--
CREATE INDEX PN
ON product_dim(ProductName);

SELECT product_dim.ProductName AS 'Product Name',SUM(sales_fact.Sales_Amt) AS 'Sales' FROM dw_lab03.sales_fact
JOIN dw_lab03.product_dim USE INDEX(PN) ON product_dim.Product_SK = sales_fact.Prod_SK
GROUP BY product_dim.ProductName
ORDER BY product_dim.ProductName;

--View 1--
CREATE VIEW customer_sales_product_prodtype AS 
SELECT customer_dim.name,product_dim.ProductName, sum(sales_fact.Qty) as TotalAmount
FROM sales_fact 
JOIN customer_dim
ON sales_fact.Cust_SK = customer_dim.Customer_SK
JOIN product_dim
ON sales_fact.Prod_SK = product_dim.Product_SK
GROUP BY customer_dim.name,product_dim.ProductName;
SELECT * FROM customer_sales_product_prodtype;

--View 2--
CREATE VIEW Sales_Year_Product AS
SELECT product_dim.ProductName, salesdate_dim.Year, SUM(sales_fact.Sales_Amt) AS 'Total Sales'
FROM dw_lab03.product_dim
LEFT JOIN dw_lab03.sales_fact ON sales_fact.Prod_SK = product_dim.Product_SK
LEFT JOIN dw_lab03.salesdate_dim ON sales_fact.SalesDate_SK = salesdate_dim.SalesDate_SK
GROUP BY product_dim.ProductName, salesdate_dim.Year
ORDER BY product_dim.ProductName, salesdate_dim.Year;
SELECT * FROM Sales_Year_Product;

