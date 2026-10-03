#!/bin/bash
# ===============================================================
# STAGE 1 — HDFS ONLY
# Run this script to demo just the storage stage: uploading the
# raw CSV into HDFS and viewing it there.
# ===============================================================

echo ">>> Creating input directory on HDFS..."
hdfs dfs -mkdir -p /bda_project/input

echo ">>> Uploading online_sales.csv to HDFS..."
hdfs dfs -put -f ../data/online_sales.csv /bda_project/input/

echo ""
echo ">>> Listing files in HDFS input folder:"
hdfs dfs -ls /bda_project/input

echo ""
echo ">>> Previewing first 5 lines of the file stored in HDFS:"
hdfs dfs -cat /bda_project/input/online_sales.csv | head -5

echo ""
echo "=== HDFS STAGE DONE — data is now stored in distributed storage ==="
