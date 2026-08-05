-- Data Cleaning
-- Preview initial raw dataset
SELECT * 
FROM sales.sales;

-- Convert string Order_Date into standard DATE format
UPDATE sales.sales
SET Order_Date = STR_TO_DATE(Order_Date, '%d/%m/%Y');

-- Convert string Ship_Date into standard DATE format
UPDATE sales.sales
SET Ship_Date = STR_TO_DATE(Ship_Date, '%d/%m/%Y');

-- Modify Order_Date column data type to DATE
ALTER TABLE sales.sales 
MODIFY COLUMN Order_Date DATE;

-- Modify Ship_Date column data type to DATE
ALTER TABLE sales.sales 
MODIFY COLUMN `Ship_Date` DATE;

-- Add stored calculated column for delivery time duration in days
ALTER TABLE sales.sales 
ADD COLUMN Delivery_Time_Days 
INT GENERATED ALWAYS AS (
    DATEDIFF(Ship_Date, Order_Date)
) STORED;

-- Remove existing Order_Delivery_Time column prior to re-creating virtual column
ALTER TABLE sales.sales 
DROP COLUMN Order_Delivery_Time;

-- Add virtual generated column to classify delivery status based on order priority criteria
alter table sales.sales 
ADD COLUMN Order_Delivery_Time 
VARCHAR(10) GENERATED ALWAYS AS (
  CASE 
	WHEN Order_Priority = 'Critical' AND Delivery_Time_Days <= 2 THEN 'on time'
    WHEN Order_Priority = 'High' AND Delivery_Time_Days <= 3 THEN 'on time'
    WHEN Order_Priority = 'Medium' AND Delivery_Time_Days <= 4 THEN 'on time'
    WHEN Order_Priority = 'Low' AND Delivery_Time_Days <= 7 THEN 'on time'
    WHEN Order_Priority = 'Not Specified' AND Delivery_Time_Days <= 100 THEN 'on time'
    ELSE 'late'
  END
) VIRTUAL;

-- Add virtual generated column categorizing product unit prices into price brackets
alter table sales.sales 
ADD COLUMN Unit_Price_Bracket
VARCHAR(10) GENERATED ALWAYS AS (
  CASE 
	WHEN Unit_Price <= 20 THEN 'Cheap'
    WHEN Unit_price <= 100 THEN 'Mid-Range'
    WHEN Unit_price >=100  THEN 'Expensive'
    ELSE 'Very Expensive'
  END
) VIRTUAL;

-- Add virtual generated column classifying order profitability status
alter table sales.sales 
ADD COLUMN Profitability_Status
VARCHAR(10) GENERATED ALWAYS AS (
  CASE 
	WHEN Profit > 20 THEN 'Profitable'
    ELSE 'Loss'
  END
) VIRTUAL;

-- Preview shipping mode and delivery performance columns
SELECT 
    Ship_Mode, 
    Delivery_Time_Days, 
    Is_On_Time 
FROM sales 
LIMIT 15;

-- Add virtual generated column to flag on-time delivery based on shipping mode thresholds
ALTER TABLE sales 
ADD COLUMN Is_On_Time 
TINYINT GENERATED ALWAYS AS (
  CASE 
    WHEN Ship_Mode = 'Express Air' AND Delivery_Time_Days <= 2 THEN 1
    WHEN Ship_Mode = 'Regular Air' AND Delivery_Time_Days <= 5 THEN 1
    WHEN Ship_Mode = 'Delivery Truck' AND Delivery_Time_Days <= 7 THEN 1
    ELSE 0
  END
)virtual;

-- Trim leading and trailing whitespace across all categorical text fields
UPDATE sales.sales
SET 
    Ship_Mode = TRIM(Ship_Mode),
    Customer_Name = TRIM(Customer_Name),
    City = TRIM(City),
    State = TRIM(State),
    Region = TRIM(Region),
    Customer_Segment = TRIM(Customer_Segment),
    Product_Category = TRIM(Product_Category),
    `Product_Sub-Category` = TRIM(`Product_Sub-Category`),
    Product_Name = TRIM(Product_Name),
    Product_Container = TRIM(Product_Container)
;

-- Check for duplicate records based on primary identifier Row_ID
SELECT Row_ID, COUNT(*) 
FROM sales.sales 
GROUP BY Row_ID 
HAVING COUNT(*) > 1;

-- Check for NULL or blank values across text, numeric, and date columns
SELECT 
    COUNT(*) AS total_rows,
    
    -- Text Columns (Check for NULL or Blank String)
    SUM(CASE WHEN Ship_Mode IS NULL OR TRIM(Ship_Mode) = '' THEN 1 ELSE 0 END) AS missing_ship_mode,
    SUM(CASE WHEN Customer_Name IS NULL OR TRIM(Customer_Name) = '' THEN 1 ELSE 0 END) AS missing_customer_name,
    SUM(CASE WHEN `Product_Sub-Category` IS NULL OR TRIM(`Product_Sub-Category`) = '' THEN 1 ELSE 0 END) AS missing_sub_cat,
    
    -- Numeric & Date Columns (Check for NULL)
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN Ship_Date IS NULL THEN 1 ELSE 0 END) AS null_ship_date,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS null_profit,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS null_sales

FROM sales.sales;

-- Check for data integrity anomalies where shipping date precedes order date
SELECT COUNT(*) as backdated_orders 
FROM sales 
WHERE Ship_Date < Order_Date;


-- EDA
-- Aggregate annual sales performance, profit metrics, and margin percentage
SELECT 
  YEAR(Order_Date) as year,
  SUM(Sales) as total_sales,
  round(sum(Profit)) as total_profit,
  ROUND(SUM(Profit) / SUM(Sales), 4) as margin_pct,
  COUNT(DISTINCT Order_ID) as order_count
FROM sales
GROUP BY YEAR(Order_Date)
ORDER BY year;

-- Calculate loss-making orders and overall profit margin by product category
SELECT 
  Product_Category,
  COUNT(*) as total_rows,
  SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END) as loss_making,
  ROUND(SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END) / COUNT(*), 4) as pct_loss,
  round(sum(Profit)) as total_profit,
  ROUND(SUM(Profit) / SUM(Sales), 4) as profit_margin
FROM sales
GROUP BY Product_Category
ORDER BY profit_margin;

-- Sub-category breakdown (worst performers)
SELECT 
  `Product_Sub-Category`,
  COUNT(*) as row_count,
  round(SUM(Sales)) as total_sales,
  round(SUM(Profit)) as total_profit,
  ROUND(SUM(Profit) / SUM(Sales), 4) as margin,
  MIN(Profit) as min_order_profit,
  MAX(Profit) as max_order_profit
FROM sales
GROUP BY `Product_Sub-Category`
ORDER BY margin ASC;

-- Region × Category profitability (the matrix for page 2)
SELECT 
  Region,
  Product_Category,
  COUNT(DISTINCT Order_ID) as order_count,
  round(SUM(Sales)) as sales,
  round(SUM(Profit)) as profit,
  ROUND(SUM(Profit) / SUM(Sales), 4) as margin
FROM sales
GROUP BY Region, Product_Category
ORDER BY Region, margin DESC;

-- Seasonality check (monthly sales)
SELECT 
  MONTH(Order_Date) as month,
  YEAR(Order_Date) as year,
  COUNT(DISTINCT Order_ID) as order_count,
  round(SUM(Sales)) as total_sales,
  round(SUM(Profit)) as total_profit
FROM sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY year, month;