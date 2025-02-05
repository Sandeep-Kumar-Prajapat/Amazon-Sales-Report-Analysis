##Data Cleaning 

## To ensure data accuracy and consistency, the following cleaning steps were performed using Excel:

## 1. Removed Duplicates: Eliminated duplicate entries to maintain data integrity.
## 2. Standardized Date Format: Converted all dates to a uniform format for consistency in time-based analysis.
## 3. Handled Missing Values: Addressed blank values by appropriate imputation or removal based on context.
## 4. Standardized Data Entries: Unified inconsistent entries (e.g., rj - RAJASTHAN, raj - RAJASTHAN delhi → DELHI) for consistency in analysis.
## 5. Removed Unnecessary Columns: Dropped columns that were not relevant to the analysis to optimize data processing.


## Again checking for data accuracy

## 1. checking for duplicates
with ranked_rows as (
SELECT *, row_number() over(partition by order_id, purchase_date, `Status`, fulfilled_by, Fulfilment, Sales_channel,
ship_service_level, Category, Size, Courier_status, Qty, Amount,state, B2B) as row_num
FROM amazon_sales.amazon_sales_report)
select *
from ranked_rows
where row_num > 1
;

## checking null values
select state
from amazon_sales.amazon_sales_report
where state is null;

## checking for negative amount values and quantity
select *
from amazon_sales_report
where Amount < 0 or Qty < 0;

## no negative values in amount and quantity




## Data Analysis


## 1. total sales and average sales per month

select month(purchase_date) as order_month,
count(order_id) as total_order,
round(sum(Amount),2) as total_sale,
round(avg(amount),2) as avg_sale
from amazon_sales_report
group by order_month
order by order_month;


## 2. Top-selling product categories

select Category, 
count(order_id) as total_order,
round(sum(Amount),2) as total_sale
from amazon_sales_report
group by Category
order by total_sale desc;


## 3. Average quantity sold per category

select Category,
round(avg(Qty),2) as avg_quantity_sold
from amazon_sales_report
group by Category
order by avg_quantity_sold desc;


## 4. Top-selling product size

select Size, 
count(order_id) as total_order,
round(sum(Amount),2) as total_sale
from amazon_sales_report
group by Size
order by total_sale desc;


## 5. Fulfillment methods 
SELECT 
    Fulfilment,
    COUNT(Order_id) AS Total_Orders
FROM amazon_sales_report
GROUP BY Fulfilment;

## 6. state wise sales

select state, 
count(order_id) as total_order,
round(sum(Amount),2) as total_sale
from amazon_sales_report
group by state
order by total_sale desc;


## 7. city wise sales 

select city, 
count(order_id) as total_order,
round(sum(Amount),2) as total_sale
from amazon_sales_report
group by city
order by total_sale desc;

