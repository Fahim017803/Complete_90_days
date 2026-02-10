# Day 14 Challenge – Firewall Blocking Traffic

## Objective
Understand how firewall rules can block traffic even when the application is running.

---

## Problem
Website was not accessible from the external network despite the service running. The objective was to identify whether a firewall rule was blocking incoming traffic.

---

## Service Check

```bash
systemctl status nginx
```

Output showed the service was running.

---

## Port Verification

```bash
ss -tulpn
```

Observed:

```
0.0.0.0:80 LISTEN
```

Application was actively listening on port 80.

---

## Firewall Check

```bash
sudo ufw status
```

Found:

```
80 DENY
```

Incoming HTTP traffic was blocked.

---

## Fix

Allow port 80:

```bash
sudo ufw allow 80
```

Verify firewall rules:

```bash
sudo ufw status
```

HTTP traffic allowed and website became accessible.

📸 Screenshot

---

## Commands Used

```bash
systemctl status nginx
ss -tulpn
sudo ufw status
sudo ufw allow 80
```

---

## What I Learned

- Firewall rules can block traffic even when services are healthy.
- Always verify firewall settings when connectivity issues occur.
- Timeout errors often indicate network-level blocking.
