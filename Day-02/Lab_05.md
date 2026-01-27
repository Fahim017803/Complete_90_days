## Lab-05: Disk Full Incident Debugging (Real DevOps Case)

### Scenario
- Server is running
- SSH works
- Application suddenly crashes
- Logs say: **No space left on device**

**Goal:** Detect disk space issues and recover safely like a DevOps engineer.

---

### Step 1: Check disk usage (first instinct)
Command: `df -h`

Observation:
- One partition (/) is near or at 100%

Reason:
- Disk full breaks apps, logs, Docker, databases
- Always check disk before touching services

---

### Step 2: Identify where space is used
Command: `sudo du -h / --max-depth=1 | sort -hr | head`

Reason:
- Find which directory is consuming space
- Prevent deleting random files

---

### Step 3: Common disk hog locations (real world)
Check individually:
```
sudo du -h /var | sort -hr | head  
sudo du -h /var/log | sort -hr | head
```

Reason:
- Logs, Docker, cache usually fill disks
- /var is the most common culprit

---

### Step 4: Simulate disk full (safe practice)
Command: `sudo fallocate -l 1G /tmp/bigfile`

Reason:
- Learn how disk pressure feels
- Practice before real incidents

---

### Step 5: Confirm disk is full
Command: `df -h`

Observation:
- Disk usage increases

---

### Step 6: Observe application failure
Command:
```
sudo systemctl restart nginx  
sudo journalctl -u nginx -n 20
```

Observation:
- Errors due to disk space

Reason:
- Services fail silently when disk is full

---

### Step 7: Clean up safely (never delete blindly)
Examples:
```
sudo rm -f /tmp/bigfile  
sudo journalctl --vacuum-time=2d
```

Optional (Docker systems):
docker system prune -af

Reason:
- Remove only confirmed junk
- Avoid deleting configs or data

---

### Step 8: Verify recovery
Command:
```
df -h  
sudo systemctl restart nginx  
curl localhost
``` 

Expected:
- Disk space available
- Application works again

---

### Key Learnings
- Disk full = silent killer
- Logs fail first when disk is full
- Always locate usage before deleting
- /var and /var/log are top suspects

---

### DevOps Rule
No disk space = no application  
Check disk BEFORE restarting services

---

### Real-world relevance
This exact issue happens with:
- Docker logs
- Kubernetes nodes
- CI/CD runners
- Production EC2 servers
