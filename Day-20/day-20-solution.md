# Day 20 – Bash Scripting Challenge
## Log Analyzer & Report Generator

## Objective
Automate log analysis using Bash scripting.

---

## Script Name
log_analyzer.sh

---

## Features Implemented

### 1. Input Validation
- Checks if log file path is provided
- Checks if file exists
- Exits with clear error messages

### 2. Error Count
- Counts lines containing:
  - ERROR
  - Failed
- Uses:
  grep -Ei "ERROR|Failed"

### 3. Critical Events
- Extracts lines containing:
  CRITICAL
- Displays with line numbers
- Uses:
  grep -n "CRITICAL"

### 4. Top 5 Error Messages
- Extracts ERROR lines
- Removes timestamp fields using awk
- Sorts and counts frequency
- Displays top 5 most common messages

Pipeline used:
grep → awk → sort → uniq -c → sort -rn → head

### 5. Summary Report
Generates:
log_report_<date>.txt

Includes:
- Date
- Log file name
- Total lines
- Total error count
- Top 5 errors
- Critical events

### 6. Optional Archive Feature
- Creates archive/ directory if not exists
- Moves processed log file to archive/

---

## Sample Output