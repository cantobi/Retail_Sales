# Retail_Sales_Intelligence

# The Profitability Paradox: Why Half of All Orders Are Losing Money

## Overview

An end-to-end sales analytics project tracing 1,482 orders (2009 to 2012) through a MySQL cleaning and EDA pipeline into an interactive Power BI dashboard. The company looks healthy on paper, $2.6M in sales and a 10.9% overall profit margin, but the real story is underneath: more than half of all orders lose money, and the losses concentrate in one category, one sub-category, and one region.

## Dashboard Preview

https://github.com/cantobi/Retail_Sales-/blob/main/Sales%20p1.png
https://github.com/cantobi/Retail_Sales-/blob/main/Sales%20p2.png
https://github.com/cantobi/Retail_Sales-/blob/main/Sales%20p3.png
https://github.com/cantobi/Retail_Sales-/blob/main/Sales%20p4.png
https://github.com/cantobi/Retail_Sales-/blob/main/Sales%20p5.png

## Tech Stack

- **MySQL**: data cleaning pipeline (trimming inconsistent text fields, imputing missing margin values, flagging imputed priorities and zero-day deliveries), dimension tables for business rules (shipping targets, discount policy, priority scoring), and exploratory SQL queries used to validate the story before a single chart was built
- **Power BI**: star-schema data model with relationships between the fact table and dimension tables, custom DAX measures, and a four-page interactive dashboard (Executive Overview, Profitability, Customer & Segment, Logistics & Delivery)

## Goals

- Trace a real dataset through a full pipeline, not just visualize raw numbers straight out of a spreadsheet
- Find where profitability actually breaks down underneath a seemingly healthy top-line figure
- Build a data model with proper relationships so business-rule-driven metrics (VIP orders, on-time delivery, discount compliance) are calculated correctly rather than hardcoded
- Practice building a dashboard someone could act on, not just look at

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
Yes. December is the strongest month ($315K in sales) and July is the weakest ($130K), consistent with holiday demand and a summer slowdown in B2B purchasing.

## Dataset

Order-level sales data spanning January 2009 to December 2012 across four US regions (Central, East, South, West), covering order details, customer segment, product category and sub-category, shipping mode, discount, and profit.
