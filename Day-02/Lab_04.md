## Day-02 | Lab-04: Log-based Debugging with journalctl (nginx)

### Scenario
- Service shows **failed**
- Restart does not fix the issue
- Application is down after a configuration change

**Goal:** Find the root cause using logs (real DevOps workflow)

---

### Step 0: One-time setup
Command:
sudo apt update  
sudo apt install -y nginx  

Reason:
- We need a real service to debug
- Nginx is commonly used in production

---

### Step 1: Confirm normal working state
Command:
systemctl status nginx  
curl localhost  

Expected:
- nginx is active
- Welcome page is displayed

Reason:
- Always confirm the baseline before creating an incident

---

### Step 2: Create a real failure (simulate human mistake)
Command:
sudo rm /etc/nginx/nginx.conf  
sudo systemctl restart nginx  

Reason:
- Config deletion or typo is a common production error
- Safe environment for practice

---

### Step 3: Check service status (symptom)
Command:
systemctl status nginx  

Observation:
- Service is in **failed** state

Reason:
- Status shows **what** happened, not **why**

---

### Step 4: Check logs (MOST IMPORTANT)
Command:
sudo journalctl -u nginx -n 50  

Observation:
- Error indicates missing `nginx.conf`

Reason:
- Logs reveal the exact root cause
- 90% of DevOps debugging happens here

---

### Step 5: Fix the real cause
Command:
sudo apt reinstall nginx  

Reason:
- Restore missing configuration
- Restarting without fixing the cause is useless

---

### Step 6: Restart and verify
Command:
sudo systemctl restart nginx  
systemctl status nginx  
curl localhost  

Expected:
- Service active
- Application works again

---

### Key Learnings
- `systemctl status` ≠ root cause
- `journalctl` is the main debugging tool
- Restart is not a fix
- Logs are your best friend in production

---

### DevOps Debug Flow
Status → Logs → Root Cause → Fix → Restart → Verify

---

### Real-world relevance
The same workflow applies to:
- Docker containers
- Kubernetes pods
- Cloud services (EC2, ECS, EKS)
