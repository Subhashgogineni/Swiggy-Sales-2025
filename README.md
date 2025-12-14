# 🍽️ Swiggy Food Delivery Analysis | Data Analytics & SQL

## 📌 Project Overview

This project delivers an **end-to-end data analytics solution** for analyzing Swiggy food delivery orders across multiple **states, cities, restaurants, and cuisines**. The objective is to transform raw transactional data into **actionable business intelligence** using **advanced SQL** and a well-structured **Star Schema data warehouse**.

The solution enables insights into **revenue performance, customer spending behavior, food trends, and operational efficiency** through scalable dimensional modeling and analytical queries.

---

## 🛠️ Tools & Technologies

* **SQL Server** – Data querying and analytics
* **Advanced SQL** – JOINs, aggregations, window functions
* **Data Modeling** – Star Schema (Fact & Dimension tables)
* **Business Intelligence Concepts** – KPIs, trend analysis

---

## 📂 Dataset Description

The dataset consists of Swiggy food delivery order records containing:

* Order date and time
* State, city, and delivery location
* Restaurant name
* Food category and dish name
* Dish price (INR)
* Customer ratings and rating counts

Each record represents a **single dish ordered** within a customer order.

---

## 🧹 1. Data Cleaning & Validation

To ensure analytical accuracy and reliability, the following steps were performed:

* Conducted **null value checks** and column-level data quality validation
* Identified and removed **duplicate records** using `ROW_NUMBER()` window function
* Handled **blank and empty string values** across categorical fields
* Ensured clean, consistent data before dimensional modeling

✔ Result: Reliable and analysis-ready dataset

---

## 🏗️ 2. Dimensional Modeling (Star Schema)

A scalable **Star Schema** was designed to support fast querying and flexible reporting.

### 🔸 Dimension Tables

* **Dim_Date** – Date, month, quarter, year attributes
* **Dim_Location** – State, city, delivery location
* **Dim_Restaurant** – Restaurant details
* **Dim_Category** – Food categories / cuisines
* **Dim_Dish** – Individual dish information

### 🔹 Fact Table

* **Fact_Swiggy** – Central fact table storing price, ratings, and foreign keys

### ✅ Modeling Outcomes

* Reduced data redundancy
* Improved query performance
* Enabled efficient time, location, and product-level analysis

---

## 📊 3. Analytics & Business Intelligence

### 📈 Key Performance Indicators (KPIs)

* **Total Orders**
* **Total Revenue (₹ Million)**
* **Average Dish Price**
* **Average Rating**

### 📅 Temporal Analysis

* Monthly, quarterly, and yearly order trends
* Order distribution by **day of the week**

### 📍 Location-Based Insights

* **Top 10 cities** by order volume
* **State-wise revenue contribution**

### 🍛 Food & Restaurant Performance

* Top 10 restaurants by number of orders
* Top food categories by **revenue** and **order volume**
* Most ordered dishes
* Cuisine performance using **orders and average ratings**

### ⭐ Customer Spending Analysis

* Order distribution across price ranges:

  * Under ₹100
  * ₹100–199
  * ₹200–299
  * ₹300–499
  * ₹500+

### 🌟 Ratings Analysis

* Distribution of dish ratings (1–5)

---

## 🛠️ 4. Technical Skills Demonstrated

* **Advanced SQL:** JOINs, GROUP BY, aggregations
* **Window Functions:** ROW_NUMBER(), PARTITION BY
* **Date Functions:** YEAR(), MONTH(), DATEPART(), DATENAME()
* **Conditional Logic:** CASE statements
* **Data Modeling:** Star Schema, fact & dimension table design
* **Query Optimization:** Efficient queries for large datasets

---

## 📉 5. Business Impact

* Enabled **data-driven decision-making** with clean and structured data
* Improved reporting speed and flexibility using dimensional modeling
* Delivered clear insights into **sales trends, customer behavior, and cuisine performance**
* Helped identify **high-performing locations, restaurants, and dishes**

---

## 🚀 Future Enhancements

* Integrate BI tools such as **Power BI / Tableau** for dashboarding
* Automate ETL pipelines for real-time data updates
* Perform customer segmentation and cohort analysis
* Add predictive analytics for demand forecasting

---

## 📎 How to Use This Repository

1. Review SQL scripts for data cleaning, modeling, and analysis
2. Explore schema design for understanding dimensional modeling
3. Use analytical queries and insights for interview discussions or business case studies

---

## 👤 Author

**Subhash Naidu Gogineni**
Aspiring Data Analyst / Data Science Intern

---

⭐ If you found this project insightful, consider starring the repository!

