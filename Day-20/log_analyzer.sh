#!/bin/bash

# =====================================
# Log Analyzer & Report Generator
# =====================================


# =========================
# Task 1: Input & Validation
# =========================

if [ "$#" -ne 1 ]; then
    echo "Error: Please provide a log file path."
    echo "Usage: $0 <log_file>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' does not exist."
    exit 1
fi


# =========================
# Task 2: Error Count
# =========================

ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$FILE" | wc -l)

echo "Total ERROR/Failed count: $ERROR_COUNT"


# =========================
# Task 3: Critical Events
# =========================

echo ""
echo "--- Critical Events ---"

CRITICAL_EVENTS=$(grep -n "CRITICAL" "$FILE")

# Format output like example:
echo "$CRITICAL_EVENTS" | while IFS=: read -r line content
do
    echo "Line $line: $content"
done


# =========================
# Task 4: Top 5 Error Messages
# =========================

echo ""
echo "--- Top 5 Error Messages ---"

TOP_ERRORS=$(grep "ERROR" "$FILE" \
    | awk '{$1=$2=$3=""; print}' \
    | sed 's/^ *//' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -5)

echo "$TOP_ERRORS"


# =========================
# Task 5: Summary Report
# =========================

DATE=$(date +%Y-%m-%d)
REPORT="log_report_${DATE}.txt"
TOTAL_LINES=$(wc -l < "$FILE")

{
echo "================================="
echo "Log Analysis Report"
echo "Date of Analysis: $DATE"
echo "Log File: $FILE"
echo "================================="
echo ""
echo "Total Lines Processed: $TOTAL_LINES"
echo "Total ERROR/Failed Count: $ERROR_COUNT"
echo ""
echo "----- Top 5 Error Messages -----"
echo "$TOP_ERRORS"
echo ""
echo "----- Critical Events -----"
echo "$CRITICAL_EVENTS" | while IFS=: read -r line content
do
    echo "Line $line: $content"
done
echo ""
} > "$REPORT"

echo ""
echo "Report generated: $REPORT"


# =========================
# Task 6: Archive Processed Log (Optional)
# =========================

mkdir -p archive
mv "$FILE" archive/

echo "Log file moved to archive/"


/Users/fahim/Desktop/Screenshot 2026-02-23 at 9.13.14 am.png