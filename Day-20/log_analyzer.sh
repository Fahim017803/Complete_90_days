#!/bin/bash

# ==========================================
# Log Analyzer Script
# Purpose:
#   1. Validate input log file
#   2. Count errors
#   3. Extract critical events
#   4. Show top 5 error messages
#   5. Generate report file
#   6. Archive processed log
# ==========================================


# ---------- 1️⃣ Input Validation ----------

# Check: Did user pass a file path?
if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

LOG_FILE="$1"

# Check: Does file exist?
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi


# ---------- 2️⃣ Basic Information ----------

# Get today's date (for report filename)
DATE=$(date +%Y-%m-%d)

# Report file name
REPORT_FILE="log_report_${DATE}.txt"

# Count total lines in log file
TOTAL_LINES=$(wc -l < "$LOG_FILE")


# ---------- 3️⃣ Count Errors ----------

# Count lines that contain ERROR or Failed (case-insensitive)
ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$LOG_FILE" | wc -l)

echo "Total ERROR/Failed count: $ERROR_COUNT"


# ---------- 4️⃣ Find Critical Events ----------

# Show CRITICAL lines with line numbers
CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE")

echo ""
echo "--- Critical Events ---"
echo "$CRITICAL_EVENTS"


# ---------- 5️⃣ Top 5 Error Messages ----------

# Steps:
#   1. Get lines with ERROR
#   2. Remove first 3 columns (usually timestamp)
#   3. Clean leading spaces
#   4. Sort
#   5. Count duplicates
#   6. Sort by highest count
#   7. Show top 5

TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" \
    | awk '{$1=$2=$3=""; print $0}' \
    | sed 's/^ *//' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -5)

echo ""
echo "--- Top 5 Error Messages ---"
echo "$TOP_ERRORS"


# ---------- 6️⃣ Generate Report File ----------

# Redirect structured output into report file
{
echo "========================================="
echo "Log Analysis Report"
echo "Date: $DATE"
echo "Log File: $LOG_FILE"
echo "========================================="
echo ""
echo "Total Lines Processed: $TOTAL_LINES"
echo "Total ERROR/Failed Count: $ERROR_COUNT"
echo ""
echo "----- Top 5 Error Messages -----"
echo "$TOP_ERRORS"
echo ""
echo "----- Critical Events -----"
echo "$CRITICAL_EVENTS"
echo ""
} > "$REPORT_FILE"

echo ""
echo "Report generated: $REPORT_FILE"


# ---------- 7️⃣ Archive Processed Log ----------

ARCHIVE_DIR="archive"

# Create archive folder if not exists
if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir "$ARCHIVE_DIR"
fi

# Move log file to archive folder
mv "$LOG_FILE" "$ARCHIVE_DIR/"

echo "Log file moved to $ARCHIVE_DIR/"