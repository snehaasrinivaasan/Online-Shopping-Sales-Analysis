# Online Shopping Sales Analysis — Big Data Tools Only

**Pipeline:** CSV → HDFS (storage) → Apache Pig (processing) → Apache Hive (analysis)

No frontend, no backend — just the Big Data tools from the practical list.

## 👥 Team Members

- B. Divyashri (112505014)
- S. Snehaa (112505030)
- G. Yogalakshmi (112505040)

## 1. Folder contents

```
online_sales_bigdata_only/
├── data/
│   └── online_sales.csv        # sample dataset (20 orders)
├── pig/
│   └── sales_analysis.pig      # Pig script: cleans data, computes best-sellers & monthly revenue
├── hive/
│   └── sales_analysis.hql      # Hive script: tables + analytical queries
├── scripts/
│   ├── 1_run_hdfs.sh
│   ├── 2_run_pig.sh
│   └── 3_run_hive.sh
└── README.md
```

## 2. Prerequisites

A Hadoop environment with HDFS, Pig, and Hive installed and running:

- Cloudera QuickStart VM / HDP Sandbox, or
- WSL2 Ubuntu with Hadoop/Pig/Hive installed manually, or
- A college lab machine that already has them set up

Start Hadoop daemons if not already running:

```bash
start-dfs.sh
start-yarn.sh
```

## 3. Run each Big Data tool separately (one at a time)

There's a `scripts/` folder with one script per tool, so you can run and demo HDFS, Pig, and Hive one at a time, in order, and show each one's output on its own before moving to the next.

```
scripts/
├── 1_run_hdfs.sh   # Stage 1 — storage only
├── 2_run_pig.sh    # Stage 2 — processing only (needs Stage 1 done)
└── 3_run_hive.sh   # Stage 3 — analysis only (needs Stage 2 done)
```

Make them executable once:

```bash
cd scripts
chmod +x *.sh
```

### Stage 1 — HDFS only

```bash
./1_run_hdfs.sh
```

Does only this:
- Creates `/bda_project/input` on HDFS
- Uploads `online_sales.csv` into it
- Lists the file and previews its first 5 lines straight from HDFS

Show this alone first — it demonstrates distributed storage, nothing else.

### Stage 2 — Pig only

```bash
./2_run_pig.sh
```

Run only after Stage 1. Does only this:
- Runs `pig/sales_analysis.pig` (reads the file from HDFS)
- Computes best-selling products and monthly revenue
- Writes results back to HDFS
- Prints both output files straight from HDFS

Show this alone next — it demonstrates ETL/processing, separate from Hive.

### Stage 3 — Hive only

```bash
./3_run_hive.sh
```

Run only after Stage 2. Does only this:
- Runs `hive/sales_analysis.hql`
- Creates the Hive tables and runs the 4 analytical queries (top products, monthly trend, category revenue, city revenue)

Show this last — it demonstrates SQL-style querying, on its own.

### Manual step-by-step (if you prefer typing commands directly instead of scripts)

HDFS:

```bash
hdfs dfs -mkdir -p /bda_project/input
hdfs dfs -put data/online_sales.csv /bda_project/input/
hdfs dfs -ls /bda_project/input
```

Pig:

```bash
pig pig/sales_analysis.pig
hdfs dfs -cat /bda_project/output/best_selling_products/part-*
hdfs dfs -cat /bda_project/output/monthly_revenue/part-*
```

Hive:

```bash
hive -f hive/sales_analysis.hql
```

## 4. What to show in your practical record / demo

| Stage          | Tool | What it demonstrates                                    |
| -------------- | ---- | ------------------------------------------------------- |
| Data ingestion | HDFS | Storing raw CSV in distributed storage                  |
| Processing     | Pig  | ETL-style transformation without writing Java MapReduce |
| Analysis       | Hive | SQL-like querying (HiveQL) on top of HDFS data          |

Suggested screenshots:
1. `hdfs dfs -ls` showing the input file uploaded
2. Pig script running (job success message)
3. `hdfs dfs -cat` of both output folders
4. Hive query results for each of the 4 queries

## 5. Customizing

- Swap `data/online_sales.csv` for a bigger dataset — no script changes needed as long as the column order matches.
- To add customer-wise spend analysis, add another `GROUP BY customer_id` block in the Pig script, following the same pattern as the product/month grouping.

## 📈 Results

| Metric              | Result                                                  |
| ------------------- | ------------------------------------------------------- |
| Top-selling product | Wireless Mouse (11 units)                               |
| Monthly revenue     | Jan ₹11,286 → Feb ₹16,088 → Mar ₹16,588 (steady growth) |
| Top category        | Fitness (₹10,693)                                       |
| Top city            | Delhi (₹11,593)                                         |

## 📝 Notes

- Re-running the Pig script requires deleting the previous output directory first (`hdfs dfs -rm -r -f /bda_project/output`), otherwise it throws an "output already exists" error.
- Do **not** run `hdfs namenode -format` after initial setup. It erases existing HDFS data.
