Data Analytics & SQL Project | Swiggy Food Delivery Analysis

Project Overview:
Designed and implemented a comprehensive data analytics solution to analyze food delivery orders across multiple states, cities, and restaurants. Built a scalable Star Schema architecture to transform raw operational data into actionable business intelligence.
Key Responsibilities & Achievements:
Data Cleaning & Validation

Performed null checks, duplicate detection, and data quality validation across 10+ columns
Removed redundant records using ROW_NUMBER() window function while maintaining data integrity
Identified and resolved blank/empty string fields to ensure analytical accuracy

Dimensional Modeling (Star Schema)

Designed and created 5 normalized dimension tables: Dim_Date, Dim_Location, Dim_Restaurant, Dim_Category, Dim_Dish
Built fact table (Fact_Swiggy) with foreign key relationships for efficient querying
Reduced data redundancy and improved query performance through proper normalization

Analytics & Business Intelligence

Developed KPIs: Total Orders, Total Revenue (INR Million), Average Dish Price, Average Rating
Conducted temporal analysis: monthly, quarterly, and yearly order trends
Performed location-based analysis identifying top 10 cities by order volume and state-wise revenue contribution
Analyzed food performance metrics: top restaurants, categories, and most-ordered dishes
Created customer spending segmentation across 5 price brackets (Under 100 to 500+)
Generated rating distribution analysis to assess customer satisfaction patterns

Technical Skills Demonstrated

Complex SQL queries with multiple JOINs, GROUP BY, and aggregation functions
Window functions (ROW_NUMBER, PARTITION BY) for data manipulation
Date functions (YEAR, MONTH, DATEPART, DATENAME) for temporal analysis
CASE statements for business logic and data categorization
Data modeling best practices and schema design

Business Impact

Enabled data-driven decision-making through organized, accessible data structure
Facilitated faster reporting and dashboard development with optimized schema
Provided clear visibility into sales trends, customer behavior, and operational performance
