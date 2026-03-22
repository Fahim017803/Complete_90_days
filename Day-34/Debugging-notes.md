# Day 34 – Docker Compose Advanced

## Problems Faced & Solutions (Real Troubleshooting Log)

This document records practical issues encountered while building a multi-container DevOps setup and how each was resolved.

---

# 🔴 Problem-1: psycopg2 Module Not Found

**Error**

ModuleNotFoundError: No module named 'psycopg2'

**Cause**

Database driver was not installed inside the container.

**Solution**

Added dependency:

psycopg2-binary

Rebuilt the image:

docker compose up --build

---

# 🔴 Problem-2: Dockerfile COPY Syntax Error

**Error**

COPY requires at least two arguments

**Cause**

Incorrect Dockerfile command.

**Solution**

Corrected:

COPY app.py .

---

# 🔴 Problem-3: pip Install Flag Typo

**Error**

no such option: --no-cashe-dir

**Cause**

Typing mistake.

**Solution**

Correct flag:

--no-cache-dir

---

# 🔴 Problem-4: Flask Container Crash (Wrong CMD)

**Error**

python: can't open file '/app/app'

**Cause**

Incorrect start command.

**Solution**

Updated:

CMD ["python", "app.py"]

---

# 🔴 Problem-5: YAML Key Spelling Mistake

**Error**

additional properties 'depend_on' not allowed

**Cause**

Wrong key spelling.

**Solution**

Correct key:

depends_on

---

# 🔴 Problem-6: Port Conflict During Scaling

**Issue**

Scaling web replicas did not work properly.

**Cause**

Static port binding:

"5000:5000"

Only one container can bind a host port.

**Solution**

Removed port mapping from web
Introduced load balancer concept.

---

# 🔴 Problem-7: NGINX Service Placement Error

**Error**

networks.backend_net additional properties 'nginx' not allowed

**Cause**

Wrong YAML indentation — nginx was written under networks section.

**Solution**

Moved nginx configuration under services block.

---

# 🔴 Problem-8: System Hang During Scaling

**Issue**

Terminal became unresponsive while running multiple containers.

**Cause**

High CPU / RAM usage on small VM.

**Solution**

Used:

docker compose down

Or restarted server if required.

---

# 🔴 Problem-9: Database Container Not Visible

**Issue**

Database container not showing in docker ps.

**Cause**

Compose project was stopped or not started properly.

**Solution**

docker compose up -d
docker compose ps
docker compose logs db

---

# 🔴 Problem-10: Networking Confusion

**Issue**

Unclear how web communicates with database.

**Learning**

* Containers communicate via service name
* Requires shared Docker network
* No public port needed for backend services

---

# 🔴 Problem-11: Postgres Restart Behaviour Confusion

**Issue**

Database logs showed start → stop → start pattern.

**Cause**

Initial database cluster setup triggers internal restart.

**Solution**

Verified final log:

database system is ready to accept connections

Understood this is normal behaviour.

---

# 🔴 Problem-12: Compose Version Warning

**Warning**

attribute `version` is obsolete

**Cause**

New Compose specification ignores version field.

**Solution**

Removed version or ignored warning safely.

---

# 🔴 Problem-13: Load Balancer Container Created but Not Started

**Issue**

Container state showed “Created”.

**Cause**

Incomplete compose execution or dependency timing.

**Solution**

docker compose up -d
docker compose start nginx

---

# 🔴 Problem-14: Named Volume Storage Confusion

**Issue**

Uncertainty about where database data is stored.

**Learning**

Docker stores named volumes under:

/var/lib/docker/volumes/

---

# 🔴 Problem-15: Internal DNS Concept Confusion

**Issue**

Why DB_HOST=db works without IP address.

**Learning**

Docker network provides internal DNS.
Service name acts as hostname.

---

# 🔴 Problem-16: Resource Limitation While Scaling

**Issue**

Server slow / unresponsive when scaling services.

**Cause**

Limited VM CPU and memory.

**Solution**

* Reduce replica count
* Monitor system via `top`
* Plan infrastructure capacity

---

# ✅ Final DevOps Learning Insight

Real DevOps expertise develops through:

* Debugging container build vs runtime errors
* Understanding networking and orchestration behaviour
* Handling resource constraints
* Designing resilient service communication

Practical troubleshooting is as important as writing configuration files.
