# 🛒 Online Shopping Sales Analysis

Online Shopping Sales Analysis using Big Data – analyzing online shopping sales data using **HDFS, Apache Pig, and Apache Hive**.

## 👥 Team Members

- B. Divyashri (112505014)
- S. Snehaa (112505030)
- G. Yogalakshmi (112505040)

## 🛠️ Technologies Used

- **HDFS** – Distributed Storage
- **Apache Pig** – Data Processing
- **Apache Hive** – Data Analysis & Querying

## 📊 Project Objective

Analyze online shopping sales data to identify:

1. Top 10 best-selling products by revenue
2. Monthly revenue trends
3. Category-wise sales performance
4. City-wise sales performance

## 📁 Dataset

- **Format:** CSV
- **Fields:** `order_id`, `product_name`, `category`, `quantity`, `unit_price`, `order_date`, `customer_city`

## 🔄 Data Pipeline

```
CSV Data → HDFS Storage → Pig Processing → Hive Analysis → Output Results
```

## 🚀 Execution Steps

### 1. Start Hadoop services

```bash
sudo service ssh start
start-dfs.sh
start-yarn.sh
mapred --daemon start historyserver
jps
```

Confirm the following processes are running: `NameNode`, `DataNode`, `SecondaryNameNode`, `ResourceManager`, `NodeManager`, `JobHistoryServer`.

### 2. Upload data to HDFS

```bash
cd ~/online_sales_bigdata_only/scripts
./1_run_hdfs.sh
```

This creates the HDFS directory and uploads `sales_data.csv`.

### 3. Run Pig script

```bash
hdfs dfs -rm -r -f /bda_project/output
./2_run_pig.sh
```

Generates:
- `best_selling_products` (top 10 products)
- `monthly_revenue`

### 4. Run Hive queries

```bash
./3_run_hive.sh
```

Runs 4 queries:
- Top-selling products
- Monthly revenue trend
- Category-wise revenue
- City-wise revenue

### 5. Stop Hadoop services (when done)

```bash
stop-yarn.sh
stop-dfs.sh
```

## 📈 Results

| Metric | Result |
|---|---|
| Top-selling product | Wireless Mouse (11 units) |
| Monthly revenue | Jan ₹11,286 → Feb ₹16,088 → Mar ₹16,588 (steady growth) |
| Top category | Fitness (₹10,693) |
| Top city | Delhi (₹11,593) |

## 📝 Notes

- Re-running the Pig script requires deleting the previous `/bda_project/output` directory first, otherwise it throws an "output already exists" error.
- Do **not** run `hdfs namenode -format` after initial setup — it erases existing HDFS data.
