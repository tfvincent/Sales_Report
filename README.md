# Project README

## Overview

This project involves analyzing transaction data using SQL and visualizing the results in Power BI. The SQL code performs various operations such as summing sales amounts, grouping data by different dimensions, and calculating growth percentages. The results are then loaded into Power BI to create insightful reports.

## SQL Code Breakdown

### 1. Basic Data Retrieval
```sql
SELECT * 
FROM transactions;
```
- Retrieves all records from the `transactions` table.

### 2. Total Sales for 2020 in Market "Mark001"
```sql
SELECT SUM(transactions.sales_amount)
FROM transactions 
INNER JOIN sales.date 
ON transactions.order_date = date.date 
WHERE date.year = 2020
AND transactions.market_code="Mark001";
```
- Calculates the total sales amount for the year 2020 in the market "Mark001".

### 3. Distinct Products in Market "Mark001"
```sql
SELECT DISTINCT product_code 
FROM transactions
WHERE market_code = "Mark001";
```
- Retrieves distinct product codes for the market "Mark001".

### 4. Yearly Sales Summary
```sql
SELECT YEAR(order_date) as year, SUM(sales_amount) as total_sales
FROM transactions
GROUP BY YEAR(order_date)
ORDER BY year;
```
- Summarizes total sales by year.

### 5. Top 5 Customers by Sales
```sql
SELECT customer_code, SUM(sales_amount) as total_sales
FROM transactions
GROUP BY customer_code
ORDER BY total_sales DESC
LIMIT 5;
```
- Lists the top 5 customers by total sales amount.

### 6. Sales by Product and Market
```sql
SELECT product_code, market_code, SUM(sales_amount) as total_sales
FROM transactions
GROUP BY product_code, market_code
ORDER BY total_sales DESC;
```
- Summarizes sales by product and market.

### 7. Monthly Sales Summary
```sql
SELECT YEAR(order_date) as year, MONTH(order_date) as month, SUM(sales_amount) as monthly_sales
FROM transactions
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
```
- Summarizes total sales by month and year.

### 8. Sales by Currency
```sql
SELECT currency, SUM(sales_amount) as total_sales
FROM transactions
GROUP BY currency;
```
- Summarizes total sales by currency.

### 9. Average Order Value by Market
```sql
SELECT market_code, AVG(sales_amount) as avg_order_value
FROM transactions
GROUP BY market_code
ORDER BY avg_order_value DESC;
```
- Calculates the average order value for each market.

### 10. Transaction Count by Product
```sql
SELECT product_code, COUNT(*) as transaction_count
FROM transactions
GROUP BY product_code
ORDER BY transaction_count DESC;
```
- Counts the number of transactions for each product.

### 11. Yearly Sales Growth
```sql
WITH yearly_sales AS (
    SELECT 
        YEAR(order_date) as year,
        SUM(sales_amount) as total_sales
    FROM 
        transactions
    GROUP BY 
        YEAR(order_date)
)
SELECT 
    current.year as current_year,
    current.total_sales as current_year_sales,
    previous.total_sales as previous_year_sales,
    CASE 
        WHEN previous.total_sales IS NOT NULL AND previous.total_sales != 0
        THEN (current.total_sales - previous.total_sales) / previous.total_sales * 100 
        ELSE NULL 
    END as growth_percentage
FROM 
    yearly_sales current
LEFT JOIN 
    yearly_sales previous ON current.year = previous.year + 1
ORDER BY 
    current_year;
```
- Calculates the year-over-year sales growth percentage.

### 12. Distinct Currencies
```sql
SELECT distinct(sales.transactions.currency)
FROM transactions;
```
- Retrieves distinct currencies used in transactions.

### 13. Count of Transactions in INR (with and without carriage return)
```sql
SELECT count(*)
FROM transactions
WHERE transactions.currency='INR\r';

SELECT count(*)
FROM transactions
WHERE transactions.currency='INR';
```
- Counts the number of transactions in INR, considering potential data entry issues with carriage returns.

### 14. Transactions in USD (with carriage return)
```sql
SELECT *
FROM transactions
WHERE transactions.currency='USD\r';
```
- Retrieves transactions in USD, considering potential data entry issues with carriage returns.

## Power BI Reports

### Reports Created
- **Revenue per Market**: Visualizes total revenue for each market.
- **Sales Quantity per Market**: Displays the number of sales transactions for each market.
- **Monthly and Yearly Filters**: Slicers to filter data by month and year.

### Insights
- **Downward Trend**: The reports indicate a downward trend in revenue over the past four years, suggesting a loss in revenue.

## Conclusion

This project demonstrates the use of SQL for data analysis and Power BI for data visualization. The SQL queries provide a comprehensive analysis of transaction data, which is then effectively visualized in Power BI to derive actionable insights.
