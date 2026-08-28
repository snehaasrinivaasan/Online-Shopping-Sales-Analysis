# Online-Shopping-Sales-Analysis
Online Shopping Sales Analysis using Big Data – A web-based application for analyzing online shopping sales data using Python, Flask, MySQL, and PySpark.
# 🛒 Online Shopping Sales Analysis

## 👥 Team Members
- **B.Divyashri**(112505014)
- **S.Snehaa **(112505030)
- **G.Yogalakshmi**(112505040)

## 🛠️ Technologies Used
- **HDFS** - Distributed Storage
- **Apache Pig** - Data Processing
- **Apache Hive** - Data Analysis & Querying

## 📊 Project Objective
Analyze online shopping sales data to identify:
1. Top 10 best-selling products by revenue
2. Monthly revenue trends
3. Category-wise sales performance

## 📁 Dataset
- **Format:** CSV
- **Fields:** order_id, product_name, category, quantity, price, order_date, customer_city

## 🔄 Data Pipeline
CSV Data → HDFS Storage → Pig Processing → Hive Analysis → Output Results

## 🚀 Execution Steps

### Upload Data to HDFS
```bash
hdfs dfs -mkdir -p /user/online-shopping/data
hdfs dfs -put data/sales_data.csv /user/online-shopping/data/