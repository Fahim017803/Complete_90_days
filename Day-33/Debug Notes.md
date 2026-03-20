# Day-33 — Docker Compose Debugging Runbook

## Purpose
Real troubleshooting experience while deploying WordPress + MySQL multi-container stack using Docker Compose on EC2.

Goal → fast revision + real DevOps debugging mindset.

---

## 1️⃣ Docker Compose Command Not Found

Error  
docker: unknown command: docker compose

Fix

```bash
sudo apt update
sudo apt install docker-compose-plugin -y
docker compose version
```

---

## 2️⃣ YAML Syntax Errors

Errors  
- additional properties 'service' not allowed  
- services.ports must be a mapping  

Fix Workflow

```bash
docker compose config
docker compose up -d
```

Learning → Always validate IaC before deployment.

---

## 3️⃣ Compose Configuration Validation

Command

```bash
docker compose config
```

Purpose  
- YAML syntax check  
- resolve `.env` variables  
- show final expanded config  
- detect deployment errors early  

---

## 4️⃣ Website Still Running After `compose down`

Cause → Browser opening localhost container.

Fix → Use EC2 public IP

```
http://EC2_PUBLIC_IP:PORT
```

---

## 5️⃣ EC2 Disk Full Issue

Diagnosis

```bash
df -h
```

Immediate Fix

```bash
docker system prune -a --volumes
```

Long-term → increase EC2 EBS disk size.

---

## 6️⃣ Vim Swap File Warning

Fix

```bash
rm -f .docker-compose.yml.swp
```

---

## 7️⃣ Read-Only File System

Fix

```bash
sudo nano docker-compose.yml
```

(after freeing disk space)

---

## 8️⃣ WordPress + MySQL Startup Delay

Debug

```bash
docker compose logs -f db
```

Wait until MySQL ready.

---

## Core Debugging Skills

- compose validation workflow  
- container lifecycle troubleshooting  
- local vs remote networking clarity  
- cloud disk space management  
- volume persistence understanding  
- log-based debugging mindset  

---

## DevOps Workflow Learned

```
Validate → Deploy → Observe → Debug → Fix
```