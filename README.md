# Retail Sales Performance & Profitability Analysis (2009–2012)

## Executive Summary

This project provides an end-to-end analytics solution evaluating business performance, revenue trends, customer segmentation, and delivery logistics across multi-year retail transaction data. Using **MySQL** for raw data extraction, cleaning, and exploratory data analysis (EDA), alongside **Power BI** and **Excel** for executive visualization, the analysis identifies critical revenue drivers, margin leakage, and operational bottlenecks.

---
## Dashboard Preview

![image](https://github.com/cantobi/Retail_Sales/blob/main/Retail%20Sales%20Project/Sales%201.png)
![image](https://github.com/cantobi/Retail_Sales/blob/main/Retail%20Sales%20Project/Sales%202.png)
![image](https://github.com/cantobi/Retail_Sales/blob/main/Retail%20Sales%20Project/Sales%203.png)
![image](https://github.com/cantobi/Retail_Sales/blob/main/Retail%20Sales%20Project/Sales%204.png)
![image](https://github.com/cantobi/Retail_Sales-/blob/main/Sales%205.png)

---
## Key Performance Indicators (KPIs)

* **Total Sales:** $2.63M
* **Total Profit Margin:** 10.91%
* **Total Unique Customers:** 536
* **Average Order Value (AOV):** $2.69K
* **Order SLA Median Delivery Time:** 2 Days

---

## Core Findings & Strategic Insights

### 1. Revenue Scale vs. Margin Friction

* **Sales Decline:** Total sales declined by **39.8% overall from 2009 through 2012**, with the most recent YoY drop sitting at -10.1%.
* **Profit Drivers:** Technology generated the highest profit contribution ($162.9K total profit at a 16% margin), led by Office Machines in the West Region ($17.7K).
* **Loss Leaders:** Tables and Bookcases generated significant margin drag, with Tables accounting for a net loss of $15.8K. Geographically, Furniture in the East region represents the single largest vulnerability (-$6.3K profit).

### 2. Customer & Segment Behavior

* **VIP Reliance:** VIP orders account for **64.28% ($1.69M)** of total sales volume, highlighting high dependence on top-tier accounts.
* **Corporate Dominance:** The Corporate segment serves as the main revenue engine (~$955K revenue).
* **Top Contributors:** Jasper Cacioppo represents the top revenue contributor ($48.13K), while Tony Sayre leads overall order volume (7 orders).

### 3. Fulfillment & SLA Performance

* **Base Logistics:** Core turnaround is efficient, maintaining a 2-day median fulfillment window. Delivery Truck serves as the fastest shipping mode (1.89 days average).
* **Logistics Vulnerabilities:** Isolated Regular Air shipments suffered severe delays reaching up to **92 days**, well outside acceptable operational SLA windows.

---

## Technical & Data Integrity Considerations

* **Shipping Cost Ambiguity:** During the exploratory phase, it was identified that raw net profit calculations may not consistently account for variable shipping costs. To preserve baseline data integrity without making unverified assumptions, the primary profit margin metric (10.91%) was left untouched, with a recommendation for a formal financial audit.
* **Data Cleansing & EDA (MySQL):** Handled missing values, standardized product/regional categorization, and executed spatial and conditional aggregations to isolate VIP customer orders from standard transactions.

---

## Business Questions This Dashboard Answers

**Is the business actually growing?**
No. Sales fell from $873K in 2009 to $525K in 2012, a 40% decline over four years, with profit falling in step.

**How profitable is the business, really?**
Overall margin sits at 10.9%, but that number hides a split book: 52% of all orders (776 of 1,482) lose money outright. The profitable half is effectively subsidizing the rest.

**Which category is the biggest problem?**
Furniture. It brings in $924K in sales but only a 2.7% margin, compared to 16% for Technology and 14.3% for Office Supplies. The Tables sub-category alone loses $15.8K on $315K in sales, the single worst-performing sub-category in the dataset.

**Where does the loss concentrate geographically?**
East region Furniture is the only region-category combination that's net negative, at -$6.3K profit. Every other combination is profitable.

**Does discounting explain the losses?**
Not really. Discount and profit correlate weakly (-0.06), so aggressive discounting alone doesn't account for where the losses come from. It's concentrated in specific sub-categories instead.

**How are customers segmented?**
Orders are split into VIP and Standard. A VIP order is one where profit is greater than $100 and quantity is greater than 10 units. Every other order is classified as Standard.

**How is delivery performance measured?**
Actual delivery time is benchmarked against a target set per shipping mode (Express Air, Regular Air, Delivery Truck) to calculate an on-time delivery rate, rather than relying on one flat threshold across all modes.

**Is there a seasonal pattern worth planning around?**
Yes. December is the strongest month ($315K in sales) and July is the weakest ($130K), consistent with holiday demand.

---

## Recommended Action Plan

1. **Plug Profit Leakage:** Re-evaluate pricing tiers, cap maximum allowable discounts on Tables and Bookcases, and review supplier/shipping costs for Furniture in the East region.
2. **Institute VIP Retention Programs:** Establish dedicated account management workflows for high-frequency and high-value client tiers (the 64.28% VIP revenue bucket).
3. **Audit Logistics Failures:** Partner with logistics teams to isolate the root cause of extreme Regular Air shipping delays (up to 92 days) to determine whether they stem from data entry errors or fulfillment breaches.
4. **Data Integrity & Decision Making:** Addressed ambiguity in net profitability calculations. Because it was unconfirmed whether shipping costs were fully deducted from net profit, I deliberately left the core profit margin metric untouched to preserve baseline data integrity, while documenting this gap for executive review.

---

## Tech Stack

* **Database Engine:** MySQL (Data Cleansing, Transformation, EDA)
* **Visualization Tools:** Power BI, Microsoft Excel
* **Data Modeling:** DAX, Data Cleaning Pipelines, Spatial & Aggregation Queries

---
## Dataset

Order-level sales data spanning January 2009 to December 2012 across four US regions (Central, East, South, West), covering order details, customer segment, product category and sub-category, shipping mode, discount, and profit.

---
## Full interactive visuals
on power bi data stories 
https://app.powerbi.com/view?r=eyJrIjoiNTNhOTQ2OGYtMjE1Ni00N2Y4LThjYTktMDI5MGEzOTZjODIyIiwidCI6ImY1MTg1YWY3LTQ2YmUtNDRhNS05MDkyLWM4ZWMwZmQ4ZDBhNyJ9
