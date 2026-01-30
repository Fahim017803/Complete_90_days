# Linux Practice – Processes and Services
Day 04 – Linux Fundamentals Practice

Today I practiced basic Linux commands related to processes, services, and logs.
I ran these commands on my system to understand how services behave and how to troubleshoot basic issues.

---

## 1. Process Checks

### Checking running processes
Command: ```ps aux```

**Observation:**
- Shows all running processes
- I can see system services and user processes

---

### 2. Real-time process monitoring
Command: `top`

 **Observation:**
- Displays CPU and memory usage live
- Useful to identify high resource usage processes

---

## 3. Service Checks

I inspected the **ssh** service becausae it is commonly used on servers.

### Checking ssh service status
Command: `systemctl status ssh**`

**Observation:**
- Service is active and running
- Shows PID and uptime information

---

### 4. Listing active services
Command: `systemctl list-units --type=service --state=running`

**Observation:**
- Displays all running system services
- Helps identify which services are currently active

---

## Log Checks

### 5. Viewing ssh service logs
Command: `journalctl -u ssh`

**Observation:**
- Shows authentication and connection logs
- Useful for debugging login issues

---

### 6. Checking recent system logs
Command: `tail -n 50 /var/log/syslog`

**Observation:**
- Displays the latest system messages
- Helpful for quick troubleshooting

---

## Mini Troubleshooting Flow

Scenario: SSH connection issue

Steps I would follow:
1. Check if the ssh service is running : systemctl status ssh
- 2. Restart the service if needed : sudo systemctl restart ssh
- 3. Check logs for errors : journalctl -u ssh
4. Monitor logs in real time : tail -f /var/log/syslog


---

## Notes

This practice helped me understand how processes, services, and logs are connected.
These commands are essential for real-world Linux and DevOps troubleshooting.

