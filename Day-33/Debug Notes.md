# Day-33 — Docker Compose Debugging Runbook

## Purpose
This document records real troubleshooting steps faced while deploying a multi-container WordPress + MySQL stack using Docker Compose on an EC2 instance.

Goal:  
Future quick revision + production-style debugging mindset.

---

# 🔎 1. Docker Compose Command Not Found

## Error
docker: unknown command: docker compose

## Root Cause
Docker Compose plugin was not installed.

## Fix
sudo apt update  
sudo apt install docker-compose-plugin -y  

## Verification
docker compose version

## Learning
Cloud servers often provide Docker Engine only.  
Compose must be installed manually.

---

# 🔎 2. YAML Syntax Validation Errors

## Errors Seen
- additional properties 'service' not allowed  
- services.ports must be a mapping  

## Root Cause
Wrong indentation / spelling mistakes in YAML.

## Fix Workflow
1. Edit file  
2. Validate config  

docker compose config  

3. Then run stack  

docker compose up -d  

## Learning
Always validate Infrastructure-as-Code before deployment.

---

# 🔎 3. Website Still Running After `compose down`

## Observation
Website accessible even after stack removal.

## Root Cause
Browser was accessing **localhost (local machine container)** instead of EC2 container.

## Fix
Use EC2 public IP:

http://EC2_PUBLIC_IP:PORT

## Learning
Understand difference between:

- localhost → current machine  
- public IP → remote server  

---

# 🔎 4. EC2 Disk Full Issue

## Error
Write error (file system full)

## Diagnosis
df -h  

Root disk usage → 100%

## Cause
Docker images, containers, volumes and logs consumed small default disk.

## Immediate Fix
docker system prune -a --volumes  

## Long-Term Fix
Increase EBS volume size (20–30GB recommended).

## Learning
Resource management is critical in cloud infrastructure.

---

# 🔎 5. Vim Swap File Warning

## Error
Swap file ".docker-compose.yml.swp" already exists

## Cause
Editor crash due to disk full or SSH interruption.

## Fix Options
Press `D` to delete swap file  
OR  

rm -f .docker-compose.yml.swp  

## Learning
Editor recovery files must be handled during server troubleshooting.

---

# 🔎 6. Read-Only File System Problem

## Cause
Linux switched to protective read-only mode when disk was full.

## Fix
1. Free disk space  
2. Reopen file using sudo  

sudo nano docker-compose.yml  

## Learning
System-level failures affect application configuration ability.

---

# 🔎 7. WordPress + MySQL Startup Delay

## Observation
WordPress page not loading immediately after stack start.

## Cause
Database initialization takes time.

## Debug Method
docker compose logs -f db  

Wait until MySQL shows ready message.

## Learning
Always check logs before assuming deployment failure.

---

# 🧠 Core Debugging Skills Gained

- Compose configuration validation workflow  
- Container lifecycle troubleshooting  
- Remote vs local networking clarity  
- Cloud disk space management  
- Volume persistence verification  
- Log-driven root cause analysis  

---

# ✅ Final Takeaway

Day-33 focused not only on deployment but also on **real infrastructure debugging.**

Key mindset developed:

- Validate → Deploy → Observe → Debug → Fix  

This is a fundamental DevOps engineering workflow.