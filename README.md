# 🏥 Hospital Database Analysis

This project involves designing, managing, and querying a **hospital database** using **SQL** and **data visualisation** in **Power BI**. The dataset includes patients, physicians, nurses, procedures, rooms, and hospital stays. The project focuses on **data retrieval, analysis, and optimization**.

##  Project Structure

- **SQL-Scripts/**
  - <a href="https://github.com/akhilanm123/Hospital-Analytics---SQL/blob/main/sql.sql">SQLScripts </a> → Contains table creation queries, data insertion queries,SQL queries answering questions.

- **Documentation/**
  -  <a href="https://github.com/akhilanm123/Hospital-Analytics---SQL/blob/main/HOSPITAL%20DATABASE%20Information.docx">Hospital_Database_Schema </a> → ER diagram and schema details.
  - <a href="https://github.com/akhilanm123/Hospital-Analytics---SQL/blob/main/Hospital%20Database%20Project%20Report.docx">Project_Report.docx </a> → Detailed explanations of queries.

##  Key Features

- **Full Hospital Database Schema**
- **Data Insertion Scripts for 50+ Patients & 6 Physicians**  
- **39 SQL Queries for Business Insights**  
- **Joins, Aggregations, and Subqueries Used**  
- **Optimized for Performance**  

## 🛠 Technologies Used

- **PostgreSQL** (Relational Database)
- **SQL Queries** (Joins, Aggregations, Subqueries)
- **Power BI** (Data Visualization)

## 📊 Sample Queries

```sql
-- Find the physician who has performed the most procedures
SELECT physician, COUNT(procedure) AS procedure_count
FROM undergoes
GROUP BY physician
ORDER BY procedure_count DESC
LIMIT 1;
