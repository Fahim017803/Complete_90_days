# Day 32 – Docker Volumes & Networking

## Objective
Understand two important Docker concepts:
1. Data persistence using volumes
2. Communication between containers using networks

Containers are ephemeral. If a container is deleted, its data is lost unless persistent storage is used.

---

# Task 1 — The Problem (No Persistence)

Run a Postgres container:

```bash
docker run -d --name postgres-test -e POSTGRES_PASSWORD=pass -p 5432:5432 postgres
```

Enter the container:

```bash
docker exec -it postgres-test psql -U postgres
```

Create a table:

```sql
CREATE TABLE users(id INT, name TEXT);
INSERT INTO users VALUES (1, 'Fahim');
SELECT * FROM users;
```

Stop and remove the container:

```bash
docker stop postgres-test
docker rm postgres-test
```

Run a new container again:

```bash
docker run -d --name postgres-test -e POSTGRES_PASSWORD=pass -p 5432:5432 postgres
```

Observation:

The table and data are **gone**.

### Reason

Containers store data in their **writable layer**, which is deleted when the container is removed.

---

# Task 2 — Named Volumes

Create a volume:

```bash
docker volume create postgres-data
```

Run container with volume:

```bash
docker run -d \
--name postgres-vol \
-e POSTGRES_PASSWORD=pass \
-v postgres-data:/var/lib/postgresql/data \
postgres
```

Add data again:

```bash
docker exec -it postgres-vol psql -U postgres
```

```sql
CREATE TABLE users(id INT, name TEXT);
INSERT INTO users VALUES (1, 'Fahim');
```

Remove the container:

```bash
docker stop postgres-vol
docker rm postgres-vol
```

Run a new container using the same volume:

```bash
docker run -d \
--name postgres-vol2 \
-e POSTGRES_PASSWORD=pass \
-v postgres-data:/var/lib/postgresql/data \
postgres
```

Check data again:

```bash
docker exec -it postgres-vol2 psql -U postgres
SELECT * FROM users;
```
postgres-vol2 container এর ভিতরে গিয়ে
PostgreSQL shell open করো

Observation:

Data **still exists**.

Check volume:

```bash
docker volume ls
docker volume inspect postgres-data
```

---

# Task 3 — Bind Mounts

Create a folder on host:

```bash
mkdir website
cd website
```

Create HTML file:

```bash
nano index.html
```

Example:

```html
<h1>Hello from Docker Bind Mount</h1>
```

Run Nginx container with bind mount:

```bash
docker run -d -p 8080:80 \
-v $(pwd):/usr/share/nginx/html \
nginx
# -d → run container in background (detached mode)
# -p 8080:80 → map host port 8080 to container port 80
# -v $(pwd):/usr/share/nginx/html → bind mount current folder to nginx web directory
```

Open browser:

```
http://localhost:8080
```

Edit `index.html` on host and refresh browser.

Observation:

Changes appear instantly.

### Named Volume vs Bind Mount

| Feature | Named Volume | Bind Mount |
|---|---|---|
| Managed by Docker | Yes | No |
| Stored inside Docker directory | Yes | No |
| Maps host folder | No | Yes |
| Best for databases | Yes | Sometimes |

---

# Task 4 — Docker Networking Basics

List networks:

```bash
docker network ls
```

Inspect default bridge network:

```bash
docker network inspect bridge
```

Run two containers:

```bash
docker run -dit --name container1 ubuntu
docker run -dit --name container2 ubuntu
```

Ping by IP:

```bash
docker exec -it container1 ping <container2_ip>
```

Ping by name:

```bash
docker exec -it container1 ping container2
```

Observation:

Default bridge network **does not support automatic DNS resolution by name**.

---

# Task 5 — Custom Networks

Create network:

```bash
docker network create my-app-net
```

Run containers on this network:

```bash
docker run -dit --name app1 --network my-app-net ubuntu
docker run -dit --name app2 --network my-app-net ubuntu
```

Ping by name:

```bash
docker exec -it app1 bash
ping app2
```

Observation:

Containers can now communicate using **container names**.

### Reason

Custom bridge networks include an **embedded DNS server**.

---

# Task 6 — Put It Together

Create network:

```bash
docker network create app-network
```

Create volume:

```bash
docker volume create db-data
```

Run database container:

```bash
docker run -d \
--name database \
--network app-network \
-e POSTGRES_PASSWORD=pass \
-v db-data:/var/lib/postgresql/data \
postgres
```

Run app container:

```bash
docker run -it \
--name app \
--network app-network \
ubuntu
```

Test connection:

```bash
docker exec -it app bash
ping database
```

Observation:

Containers communicate using **container names**.

---

# Key Learnings

- Containers are ephemeral; data is lost when containers are removed
- Volumes provide persistent storage
- Named volumes are managed by Docker
- Bind mounts link host directories directly to containers
- Docker networks allow containers to communicate
- Custom bridge networks provide automatic DNS-based service discovery