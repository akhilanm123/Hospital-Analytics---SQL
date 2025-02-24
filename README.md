# 🏥 Hospital Database Analysis

This project involves designing, managing, and querying a **hospital database** using **SQL** and **data visualisation** in **Power BI**. The dataset includes patients, physicians, nurses, procedures, rooms, and hospital stays. The project focuses on **data retrieval, analysis, and optimization**.

## 📂 Project Structure

- **SQL-Scripts/**
  - `create_tables.sql` → Contains table creation queries.
  - `insert_data.sql` → Contains data insertion queries.
  - `queries_part1.sql` → SQL queries answering questions 1-25.
  - `queries_part2.sql` → SQL queries answering questions 26-39.

- **Documentation/**
  - `Hospital_Database_Schema.pdf` → ER diagram and schema details.
  - `Project_Report.docx` → Detailed explanations of queries.

## 🔍 Key Features

✔ **Full Hospital Database Schema**  
✔ **Data Insertion Scripts for 50+ Patients & 6 Physicians**  
✔ **39 SQL Queries for Business Insights**  
✔ **Joins, Aggregations, and Subqueries Used**  
✔ **Optimized for Performance**  

## 🛠 Technologies Used

- **PostgreSQL / MySQL** (Relational Database)
- **SQL Queries** (Joins, Aggregations, Subqueries)
- **GitHub** (Version Control)
- **Power BI/Tableau** (Optional - Data Visualization)

## 📊 Sample Queries

```sql
-- Find the physician who has performed the most procedures
SELECT physician, COUNT(procedure) AS procedure_count
FROM undergoes
GROUP BY physician
ORDER BY procedure_count DESC
LIMIT 1;
