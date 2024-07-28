SELECT * 
FROM transactions;

SELECT SUM(transactions.sales_amount)
FROM transactions 
INNER JOIN sales.date 
ON transactions.order_date = date.date 
WHERE date.year = 2020
AND transactions.market_code="Mark001";

SELECT DISTINCT product_code 
FROM transactions
WHERE market_code = "Mark001";

SELECT YEAR(order_date) as year, SUM(sales_amount) as total_sales
FROM transactions
GROUP BY YEAR(order_date)
ORDER BY year;

SELECT customer_code, SUM(sales_amount) as total_sales
FROM transactions
GROUP BY customer_code
ORDER BY total_sales DESC
LIMIT 5;

SELECT product_code, market_code, SUM(sales_amount) as total_sales
FROM transactions
GROUP BY product_code, market_code
ORDER BY total_sales DESC;

SELECT YEAR(order_date) as year, MONTH(order_date) as month, SUM(sales_amount) as monthly_sales
FROM transactions
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

SELECT currency, SUM(sales_amount) as total_sales
FROM transactions
GROUP BY currency;

SELECT market_code, AVG(sales_amount) as avg_order_value
FROM transactions
GROUP BY market_code
ORDER BY avg_order_value DESC;

SELECT product_code, COUNT(*) as transaction_count
FROM transactions
GROUP BY product_code
ORDER BY transaction_count DESC;

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

SELECT distinct(sales.transactions.currency)
FROM transactions;

SELECT count(*)
FROM transactions
WHERE transactions.currency='INR\r';

SELECT count(*)
FROM transactions
WHERE transactions.currency='INR';

SELECT *
FROM transactions
WHERE transactions.currency='USD\r';