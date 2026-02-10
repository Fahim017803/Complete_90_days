# Day 14 Challenge – Service Down Detection

## Objective
Identify how a stopped service impacts website availability.

---

## Break the Service

Stop nginx:

sudo systemctl stop nginx

Test:

`curl localhost`

Result:
connection refused

---

## Identify the Issue

Check service:

`systemctl status nginx`

Output:
inactive (dead)

---

## Fix

`sudo systemctl start nginx`

Verify:

`curl localhost`

Website restored.

📸 Screenshot

---

## Commands Used

```
systemctl  
curl  
```
---

## What I Learned
- Applications depend on running services.
- Server uptime does not guarantee application uptime.
- Service status should be checked early during troubleshooting.
