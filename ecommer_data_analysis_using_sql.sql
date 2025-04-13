create database ecommerce;
use ecommerce;
select * from ecommerce.cleaned_transaction_dataset limit 10;

-- Top 5 Brands by Total Sales Revenue
SELECT brand, SUM(list_price) AS total_revenue
FROM ecommerce.cleaned_transaction_dataset
GROUP BY brand
ORDER BY total_revenue DESC
LIMIT 5;

-- Monthly Sales Trend
SELECT 
    DATE_FORMAT(CAST(transaction_date AS DATETIME), '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    SUM(list_price) AS total_sales
FROM ecommerce.cleaned_transaction_dataset
WHERE transaction_date IS NOT NULL
GROUP BY month
ORDER BY month;

-- Most Profitable Product Lines
SELECT 
    product_line, 
    SUM(list_price - standard_cost) AS total_profit
FROM ecommerce.cleaned_transaction_dataset
GROUP BY product_line
ORDER BY total_profit DESC;

-- Orders Count by Online/Offline Mode
SELECT 
    online_order,
    COUNT(*) AS order_count
FROM ecommerce.cleaned_transaction_dataset
GROUP BY online_order;

-- Create a View for Revenue & Profit Analysis
CREATE VIEW revenue_profit_summary AS
SELECT 
    brand,
    product_line,
    COUNT(*) AS total_orders,
    SUM(list_price) AS revenue,
    SUM(list_price - standard_cost) AS profit
FROM ecommerce.cleaned_transaction_dataset
GROUP BY brand, product_line;

SELECT * FROM revenue_profit_summary ORDER BY profit DESC;

-- Customers with High Average Order Value
SELECT customer_id, AVG(list_price) AS avg_order_value
FROM ecommerce.cleaned_transaction_dataset
GROUP BY customer_id
HAVING avg_order_value > (
    SELECT AVG(list_price) FROM cleaned_transaction_dataset
);

-- Total Cost and Profit Per Transaction

SELECT 
    transaction_id,
    list_price,
    standard_cost,
    (list_price - standard_cost) AS profit
FROM ecommerce.cleaned_transaction_dataset;

-- Max and Min Sales for each product 

SELECT product_id, 
       MAX(list_price) AS max_sale, 
       MIN(list_price) AS min_sale
FROM ecommerce.cleaned_transaction_dataset
GROUP BY product_id
ORDER BY product_id;

