🍽️ Swiggy Food Delivery Analysis — Data Analytics & SQL Project
📌 Project Overview

This project presents an end-to-end data analytics solution for analyzing Swiggy food delivery orders across multiple states, cities, and restaurants.
A Star Schema data warehouse was designed to transform raw operational data into actionable business intelligence for revenue insights, customer behavior, and food performance analytics.

🧹 1. Data Cleaning & Validation

Performed detailed validation to ensure data accuracy and integrity:

Conducted null checks, duplicate detection, and column-level data quality checks.

Removed redundant records using ROW_NUMBER() window function.

Handled blank / empty string fields for analytical consistency.

Ensured reliable input for dimensional modeling and KPIs.

🏗️ 2. Dimensional Modeling (Star Schema)

Designed a scalable and analytics-friendly schema:

🔸 Dimension Tables

Dim_Date

Dim_Location

Dim_Restaurant

Dim_Category

Dim_Dish

🔹 Fact Table

Fact_Swiggy (linked using foreign keys)

Outcome:
✔ Reduced redundancy
✔ Improved query performance
✔ Enabled fast reporting and flexible analysis

📊 3. Analytics & Business Intelligence

Generated meaningful insights across multiple business areas:

📈 Key KPIs

Total Orders

Total Revenue (₹ Million)

Average Dish Price

Average Rating

📅 Temporal Analysis

Monthly, quarterly, and yearly order trends

Seasonality and revenue fluctuations

📍 Location-Based Insights

Top 10 cities by order volume

State-wise revenue contribution

🍛 Food & Restaurant Performance

Most-ordered dishes

Top restaurants and categories

Price-segment analysis across 5 customer spending brackets

⭐ Customer Satisfaction

Rating distribution patterns

Quality insights for vendor performance

🛠️ 4. Technical Skills Demonstrated

Advanced SQL: JOINs, GROUP BY, aggregations

Window Functions: ROW_NUMBER(), PARTITION BY

Date Functions: YEAR(), MONTH(), DATEPART(), DATENAME()

Conditional Logic: CASE statements

Data Modeling: Star Schema, normalization, fact/dimension design

Performance Optimization: Efficient queries for large datasets

📉 5. Business Impact

Enabled data-driven decision-making with organized and clean data structures

Improved reporting efficiency through optimized schema design

Delivered clear visibility into sales trends, customer behavior, and operational performance
