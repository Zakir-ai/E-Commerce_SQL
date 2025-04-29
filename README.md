# 🛒 E-Commerce Sales Analysis using PostgreSQL


## 🧾 Project Objective

The objective of this project is to conduct an end-to-end analysis of e-commerce transactional data using SQL in a PostgreSQL environment. This includes cleaning raw sales data, performing exploratory and time-based analysis, identifying business insights, and presenting key performance metrics that can guide strategic decisions in sales, marketing, and customer engagement.

---

## 🛠️ Tools & Technologies Used

- [**PostgreSQL**](https://www.postgresql.org/download/) – for database creation, querying, and aggregation  
- [**pgAdmin**](https://www.pgadmin.org/download/) – for managing the PostgreSQL database and importing CSV files
- *(Optional for Visualization)* [**Power BI**](https://powerbi.microsoft.com/downloads/), [**Tableau**](https://www.tableau.com/products/desktop/download), or **Excel** – for dashboards and visual reports
- **SQL** – for data cleaning, transformation, and complex analysis  
- **CSV File** – as the raw transactional data source  

---

## 📂 Dataset Description

The dataset contains historical transaction records from an online retail store, with the following key fields:

- **Order ID**
- **Product ID**
- **Description**
- **Quantity**
- **Order Date & Time**
- **Unit Price**
- **Customer ID**
- **Country**
- **Amount** *(derived as: quantity × unit price)*

---

## 🔄 Process Workflow

### 1. Data Preparation
- Loaded raw CSV data into PostgreSQL.
- Created a structured table (`cleaned_orders`) with appropriate data types.
- Added a calculated `amount` column.

### 2. Data Cleaning
- Removed invalid entries:
  - Negative or zero quantity and price.
  - Rows with NULL values in critical fields.

### 3. Exploratory Data Analysis (EDA)
- Counted total orders, unique customers, and products.
- Listed unique countries.
- Detected anomalies and missing values.

---

## 📊 Key Analytical Insights

### ✅ Monthly Sales Trend
- Extracted year and month from order dates.
- Aggregated revenue and order count per month.
- Sorted chronologically to reveal trends and seasonality.

### ✅ Top-Selling Products
- Ranked products by units sold and revenue.
- Identified best performers in terms of sales volume and income.

### ✅ Revenue by Country
- Calculated total revenue per country.
- Highlighted top international markets.

### ✅ Loyal Customers
- Aggregated total spend by customer.
- Identified top-spending customers.

### ✅ Time-of-Day Sales Analysis
- Categorized sales into morning, afternoon, evening, and night shifts.
- Revealed customer buying behavior across the day.

### ✅ Monthly Average Order Value (AOV)
- Computed average revenue per order monthly.
- Provided insights into purchasing power and behavior over time.

### ✅ Anomaly Detection
- Flagged transactions with very high quantity for investigation.
- Useful for fraud detection or bulk sale alerts.

---

## 🧠 SQL Techniques Applied

- `EXTRACT(MONTH)`, `EXTRACT(YEAR)` for time grouping
- `GROUP BY`, `ORDER BY`, `LIMIT` for structured insights
- Aggregate functions: `SUM()`, `COUNT(DISTINCT)`, `AVG()`, `ROUND()`
- Conditional logic using `CASE WHEN` for time shifts
- Full NULL validation and removal during data cleaning

---

### 🛠️ How to Run the SQL File (PostgreSQL)

1. **Download** the `.sql` file from this repository.
2. Open **pgAdmin** or your preferred PostgreSQL tool.
3. **Create a new database** (right-click on Databases → New Database).
4. Once created, **right-click on the new database**, choose **"Restore"**.
5. In the restore dialog, select the downloaded `.sql` file.  
6. **Just a quick reminder** — when restoring the file, please make sure to upload it in `.sql` format instead of the default `.backup` format. By default, the system tends to open files as `.backup`.
7. Click **Restore**.
8. The database will now be populated — you can start running queries!

---

## 📌 Conclusion
This project demonstrates how structured SQL analysis on a PostgreSQL database can turn raw e-commerce transaction data into actionable insights. It lays the foundation for data-driven decision-making in retail operations.
