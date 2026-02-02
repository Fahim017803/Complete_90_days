# Part 2 — Scenario-Based Practice (Real Lab)

These labs simulate production-style failures to build real troubleshooting confidence.

==================================================

# Scenario 1 — Nginx Not Running After Reboot

## Create the Problem
sudo systemctl disable nginx  (not immidiate stop, but after rebbot it will not run)
sudo systemctl stop nginx  (Immidiate stop but after reboot it will run again)

This simulates a server reboot where nginx does not start.

---

## Diagnose

### Check Status
systemctl status nginx  

Why:
Confirm whether the service is inactive or failed.

---

### Check Logs
journalctl -u nginx -n 50  

Why:
Logs often reveal the root cause immediately.

---

## Fix

### Start Service
sudo systemctl start nginx  

Why:
Restore service quickly.

---

### Enable on Boot (CRITICAL)
sudo systemctl enable nginx  

Why:
Prevents the same outage after future reboots.

---

### Verify
systemctl is-enabled nginx  

Expected:
enabled  

✅ Learning:  
Starting fixes the present.  
Enabling protects the future.

==================================================

# Scenario 2 — High CPU Usage

## Create the Problem
sudo apt install stress -y  
stress --cpu 2  

This intentionally spikes CPU usage.

---

## Diagnose

top  

Why:
Shows real-time CPU consumption.

---

ps aux --sort=-%cpu | head  

Why:
Identifies the process causing high usage.

---

## Fix

Stop the stress process:

CTRL + C  
or  
pkill stress  

✅ Learning:  
Never kill a process before identifying it.

==================================================

# Scenario 3 — Nginx Failure Due to Bad Configuration

## Create the Problem
sudo nano /etc/nginx/nginx.conf  

Add an invalid line such as:
error_here;

---

## Diagnose

sudo nginx -t  

Why:
Detect configuration syntax errors.

---

journalctl -u nginx -n 20  

Why:
Logs confirm why nginx failed.

---

## Fix

Remove the invalid line.

Test again:
sudo nginx -t  

Expected:
syntax is ok  

---

Restart:
sudo systemctl restart nginx  

---

Enable for reboot safety:
sudo systemctl enable nginx  

✅ Learning:  
Always test configuration before restarting production services.

==================================================

# Scenario 4 — Permission Denied Script

## Create the Problem

nano backup.sh  

Add:
echo "backup running"

Try running:
./backup.sh  

You will receive:
Permission denied

---

## Diagnose

ls -l backup.sh  

Why:
Check if execute permission exists.

---

## Fix

chmod +x backup.sh  

Run again:
./backup.sh  

Now it executes successfully.

✅ Learning:  
Without execute permission, scripts cannot run.

--------------------------------------------------

# Key Takeaways

- Always check **status → logs → config → fix → enable**
- Logs are the fastest way to identify problems
- Validate configurations before restarting services
- Permissions directly control execution
- Fixing is temporary — enabling makes it permanent

## Golden Rule:
Break things safely in a lab so you never break production.
