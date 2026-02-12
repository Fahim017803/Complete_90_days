# Day 15 Reflection — Networking Concepts

Today helped me see networking as a connected system rather than separate topics. Every request depends on DNS resolution, correct IP routing, proper subnet design, and an open port.

---

## ✅ Task 1 — DNS
Running `dig google.com` showed how a domain quickly maps to an IP address and how TTL controls caching.

**Key Thought:** If DNS fails, the request never reaches the server.

---

## ✅ Task 2 — IP Addressing
Using `ip addr show` confirmed my server runs on a private IP (`172.31.x.x`), meaning internal communication happens inside the VPC while public access is handled through NAT.

**Key Thought:** Good architecture limits public exposure and keeps services private.

---

## ✅ Task 3 — CIDR & Subnetting
Understanding `/24` clarified how networks control capacity and segmentation.

| CIDR | Usable Hosts |
|--------|---------------|
| /24 | 254 |
| /16 | 65,534 |
| /28 | 14 |

**Key Thought:** Subnetting is planning for scale, not just network math.

---

## ✅ Task 4 — Ports
Checking ports with `ss -tulpn` reinforced that a service is reachable only if it is listening.

**Key Thought:** Closed port = unreachable application.

---

## ✅ Task 5 — Putting It Together
A request like:

```bash
curl http://myapp.com:8080
