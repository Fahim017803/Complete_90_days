## Debugging and Issues Faced

During this project I encountered several real deployment problems and resolved them step by step.

### 1. Docker Compose Build Flag Error

Problem:

```
unknown flag: --build
```

Cause:

The server had an older Docker / Compose version.

Solution:

Used legacy command:

```
docker-compose up --build
```

or updated Docker.

---

### 2. Website Not Accessible via Public IP

Problem:

Browser could not open:

```
SERVER_IP:8000
```

Cause:

Incorrect port exposure and security group configuration.

Solution:

- Exposed correct port in docker-compose
- Used port **8080**
- Allowed port 8080 in AWS Security Group

---

### 3. Frontend Save Action Not Working

Problem:

Notes were not being saved from the UI.

Cause:

Frontend API requests were not reaching the backend due to incorrect Nginx routing.

Solution:

Configured reverse proxy properly:

```
location /api/ {
    proxy_pass http://backend:5000/;
}
```

---

### 4. Backend Could Not Connect to Database

Problem:

Backend connection errors occurred.

Cause:

Used `localhost` as database host.

Inside Docker, `localhost` refers to the same container.

Solution:

Used Docker service name as hostname:

```
DB_HOST=db
```

---

### 5. Curl Not Available Inside Container

Problem:

```
curl: command not found
```

Cause:

Slim container images do not include curl.

Solution:

Tested connectivity using Python:

```
python -c "import urllib.request; print(urllib.request.urlopen('http://localhost:5000/notes').read())"
```

---

### 6. Data Loss After Container Restart

Problem:

Saved notes disappeared after restarting containers.

Cause:

Database volume was not configured.

Solution:

Added persistent named volume:

```
volumes:
  - notesdata:/var/lib/postgresql/data
```

---

### 7. Fresh Deployment Validation

Performed full clean deployment test:

```
docker system prune -a
docker compose up
```

System successfully rebuilt and ran using only project configuration and Docker image.

---

## Debugging Learning Outcome

This project helped improve real DevOps troubleshooting skills:

- Understanding Docker networking
- Configuring reverse proxy routing
- Implementing persistent storage
- Validating portable deployments
- Diagnosing container runtime issues