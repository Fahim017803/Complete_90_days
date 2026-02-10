# Day 14 Challenge – DNS Failure Simulation

## Objective
Understand how DNS failure impacts connectivity even when the network and server are functioning correctly.

---

## Problem
Website could not be reached using its domain name. The objective was to determine whether the issue was related to DNS resolution rather than network connectivity.

---

## DNS Failure Test

Stop the DNS resolver:

```bash
sudo systemctl stop systemd-resolved
```

---

## Domain Check

```bash
ping google.com
```

Result:

```
Temporary failure in name resolution
```

Domain could not be resolved.

---

## Network Verification

```bash
ping 8.8.8.8
```

Reply received successfully.

Network connectivity remained intact.

---

## Fix

Restart the DNS resolver:

```bash
sudo systemctl restart systemd-resolved
```

Verify domain resolution:

```bash
ping google.com
```

DNS working normally.

📸 Screenshot

---

## Commands Used

```bash
sudo systemctl stop systemd-resolved
ping google.com
ping 8.8.8.8
sudo systemctl restart systemd-resolved
```

---

## What I Learned

- DNS failure can make healthy servers appear unreachable.
- If a domain fails but the IP works, the issue is DNS.
- Always test both domain and IP to isolate connectivity problems.
