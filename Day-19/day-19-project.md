# Day 19 – Shell Scripting Project  
## Log Rotation, Backup & Crontab Automation

---

# 🎯 Objective

Automate real server maintenance tasks using:

- Shell scripting
- Log rotation
- Backup strategy
- Cron scheduling
- Combined maintenance orchestration

This simulates real DevOps production workflows.

---

# 📁 Folder Structure

```
2026/day-19/
│
├── log_rotate.sh
├── backup.sh
├── maintenance.sh
└── day-19-project.md
```

---

# ✅ Task 1 — Log Rotation Script

## Goal

- Compress `.log` files older than 7 days
- Delete `.gz` files older than 30 days
- Count compressed and deleted files
- Exit if directory does not exist

---

## 📄 log_rotate.sh

```bash
#!/bin/bash

LOG_DIR="$1"

# Check if argument provided
if [ -z "$LOG_DIR" ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

# Check if directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Directory does not exist."
    exit 1
fi

echo "Starting log rotation..."

compressed=$(find "$LOG_DIR" -type f -name "*.log" -mtime +7 \
    -exec gzip {} \; -print | wc -l)

deleted=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 \
    -print -delete | wc -l)

echo "Log rotation completed."
echo "Compressed files: $compressed"
echo "Deleted files: $deleted"
```

---

# ✅ Task 2 — Server Backup Script

## Goal

- Create timestamped `.tar.gz` archive
- Verify success
- Print archive name and size
- Delete backups older than 14 days
- Exit if source doesn't exist

---

## 📄 backup.sh

```bash
#!/bin/bash

SOURCE="$1"
DEST="$2"

if [ -z "$SOURCE" ] || [ -z "$DEST" ]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

if [ ! -d "$SOURCE" ]; then
    echo "Source directory does not exist."
    exit 1
fi

DATE=$(date +%Y-%m-%d)
ARCHIVE="$DEST/backup-$DATE.tar.gz"

echo "Starting backup..."

tar -czf "$ARCHIVE" "$SOURCE"

if [ $? -ne 0 ]; then
    echo "Backup failed."
    exit 1
fi

echo "Backup successful!"
echo "Archive created: $(basename $ARCHIVE)"
du -h "$ARCHIVE"

find "$DEST" -type f -name "backup-*.tar.gz" -mtime +14 -delete

echo "Old backups cleanup completed."
```

---

# ✅ Task 3 — Cron Scheduling

## Cron Syntax

```
* * * * *  command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

---

## Cron Entries

### Run log rotation daily at 2 AM

```bash
0 2 * * * /home/ubuntu/shell-scripting/Day-04/task-01/log_rotate.sh /home/ubuntu/shell-scripting/Day-04/task-01/testlogs >> /home/ubuntu/log_rotate.log 2>&1
```

### Run backup every Sunday at 3 AM

```bash
0 3 * * 0 /home/ubuntu/shell-scripting/Day-04/task-02/backup.sh /home/ubuntu/shell-scripting/Day-04/task-02/data /home/ubuntu/shell-scripting/Day-04/task-02/back-up >> /home/ubuntu/backup.log 2>&1
```

---

# ✅ Task 4 — Combined Maintenance Script

## Goal

- Run log rotation
- Run backup
- Log everything into one file
- Schedule daily execution

---

## 📄 maintenance.sh

```bash
#!/bin/bash

echo "=============================="
echo "Maintenance started at: $(date)"

# Run log rotation
/home/ubuntu/shell-scripting/Day-04/task-01/log_rotate.sh \
/home/ubuntu/shell-scripting/Day-04/task-01/testlogs

# Run backup
/home/ubuntu/shell-scripting/Day-04/task-02/backup.sh \
/home/ubuntu/shell-scripting/Day-04/task-02/data \
/home/ubuntu/shell-scripting/Day-04/task-02/back-up

echo "Maintenance finished at: $(date)"
echo "=============================="
```

---

## Cron Entry for Maintenance

```bash
0 1 * * * /home/ubuntu/shell-scripting/Day-04/maintenance.sh >> /var/log/maintenance.log 2>&1
```

---

# 🧪 Verification Commands

Check cron service:

```bash
systemctl status cron
```

Check scheduled jobs:

```bash
crontab -l
```

Check logs:

```bash
tail -n 50 /home/ubuntu/log_rotate.log
tail -n 50 /home/ubuntu/backup.log
tail -n 50 /var/log/maintenance.log
```

---

# 🧠 Key Learnings

1. Automating system tasks using shell scripts  
2. Time-based scheduling with cron  
3. Log rotation and cleanup strategy  
4. Backup compression using tar  
5. Output redirection (`>>`, `2>&1`)  
6. Combining scripts into maintenance pipelines  

---

# 🚀 DevOps Concepts Applied

- Automation
- Scheduled operations
- Disaster recovery planning
- Log management
- Production verification
- Maintenance orchestration

---

# 📌 Conclusion

Day 19 demonstrates real production-style automation  
used in DevOps environments.

This marks the transition from manual system work  
to fully automated infrastructure operations.
