#!/bin/bash
# ===============================================================
# STAGE 3 — HIVE ONLY
# Run this AFTER 2_run_pig.sh has produced output on HDFS.
# Demos just the analysis stage: Hive tables + SQL-style queries.
# ===============================================================

echo ">>> Running Hive script (sales_analysis.hql)..."
hive -f ../hive/sales_analysis.hql

echo ""
echo "=== HIVE STAGE DONE — queries above show best-selling products, ==="
echo "=== monthly revenue trend, category-wise & city-wise revenue    ==="
