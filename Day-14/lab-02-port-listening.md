# Day 14 Challenge – Port Listening Verification

## Objective
Understand why applications must listen on a port to accept traffic.

---

## Port Check

```bash
ss -tulpn
```

Observed:

```
0.0.0.0:80 LISTEN
```

Nginx is actively listening on port 80.

---

## Simulate Failure

Stop nginx:

```bash
sudo systemctl stop nginx
```

Check ports again:

```bash
ss -tulpn
```

Result:

```
Port 80 not visible
```

Application is no longer accepting connections.

---

## Fix

Start nginx:

```bash
sudo systemctl start nginx
```

Verify:

```bash
ss -tulpn
```

Port 80 is visible again.

📸 Screenshot

---

## Commands Used

```bash
ss -tulpn
systemctl stop nginx
systemctl start nginx
```

---

## What I Learned

- Applications must listen on a port to accept traffic.
- No listening port means no connectivity.
- Port checks help quickly detect application failures.
