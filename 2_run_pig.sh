#!/bin/bash
# ===============================================================
# STAGE 2 — PIG ONLY
# Run this AFTER 1_run_hdfs.sh has uploaded the data.
# Demos just the processing stage: Pig reads from HDFS, computes
# best-selling products & monthly revenue, writes back to HDFS.
# ===============================================================

echo ">>> Running Pig script (sales_analysis.pig)..."
pig ../pig/sales_analysis.pig

echo ""
echo ">>> Output: best_selling_products"
hdfs dfs -cat /bda_project/output/best_selling_products/part-* 2>/dev/null

echo ""
echo ">>> Output: monthly_revenue"
hdfs dfs -cat /bda_project/output/monthly_revenue/part-* 2>/dev/null

echo ""
echo "=== PIG STAGE DONE — processed results written to /bda_project/output ==="
