# Day 14 Challenge – Incident Simulation (Broken Configuration)

## Objective
Practice diagnosing a service outage caused by a configuration error.

---

## Problem
Website became unreachable after a configuration change. The objective was to identify the root cause and restore service availability.

---

## Failure Simulation

Edit nginx configuration:

```bash
sudo nano /etc/nginx/sites-enabled/default
```

(Intentionally removed a bracket to create a syntax error.)

Restart nginx:

```bash
sudo systemctl restart nginx
```

Service failed to start.

---

## Service Check

```bash
systemctl status nginx
```

Output indicated the service was in a failed state.

---

## Configuration Validation

```bash
sudo nginx -t
```

Result showed a syntax error along with the affected line number.

---

## Fix

Correct the configuration and validate again:

```bash
sudo nginx -t
```

Restart nginx:

```bash
sudo systemctl restart nginx
```

Verify:

```bash
curl localhost
```

Website restored successfully.

📸 Screenshot

---

## Commands Used

```bash
sudo nano /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
systemctl status nginx
sudo nginx -t
curl localhost
```

---

## What I Learned

- Small configuration errors can cause major service outages.
- Always validate configuration before restarting services.
- Tools like `nginx -t` help detect issues quickly.
- Structured troubleshooting reduces downtime.
