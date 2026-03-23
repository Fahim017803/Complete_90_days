# Day 35 – Multi-Stage Builds & Docker Hub

## 🎯 Objective
Build optimized Docker images using multi-stage builds and publish them to Docker Hub.

---

## ✅ Task-1: Problem with Large Images

Created a simple Node.js Express app and built it using a single-stage Dockerfile.

### app.js
```js
const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("🚀 Multi-Stage Build Demo Running");
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
```

### package.json
```json
{
  "name": "day35-node-app",
  "version": "1.0.0",
  "dependencies": {
    "express": "^4.18.2"
  }
}
```

### 🔴 Single-Stage Dockerfile (Large Image)
```dockerfile
FROM node:18

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node","app.js"]
```

### Build
```bash
docker build -t node-big .
```

### Result
Image size ≈ **800–900MB**  
Contains build tools, cache and unnecessary dependencies.

---

## ✅ Task-2: Multi-Stage Build

Used a builder stage and a lightweight runtime stage.

### 🟢 Multi-Stage Dockerfile
```dockerfile
# Stage-1 Build
FROM node:18 AS builder

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .

# Stage-2 Runtime
FROM node:18-alpine

WORKDIR /app
COPY --from=builder /app .

EXPOSE 3000

CMD ["node","app.js"]
```

### Build
```bash
docker build -t node-small .
```

### Result
Image size ≈ **120–200MB**  
Build dependencies removed and runtime image is lightweight.

---

## 📊 Size Comparison

| Image | Approx Size |
|------|-------------|
| node-big | ~900MB |
| node-small | ~150MB |

**Reason:**  
Multi-stage builds remove unnecessary build tools and use a minimal runtime base image.

---

## ✅ Task-3: Push Image to Docker Hub

### Login
```bash
docker login
```

### Tag
```bash
docker tag node-small fahim017803/day-35-small-image:v1
```

### Push
```bash
docker push fahim017803/day-35-small-image:v1
```

### Verify Pull
```bash
docker rmi -f fahim017803/day-35-small-image:v1
docker pull fahim017803/day-35-small-image:v1
```

Docker Hub Repository:  
https://hub.docker.com/r/fahim017803/day-35-small-image

---

## ✅ Task-4: Docker Hub Concepts

- Repository stores container images  
- Tags represent versions (`v1`, `latest`, `prod`)  
- Pulling a specific tag ensures stable deployments  

Example:
```bash
docker pull fahim017803/day-35-small-image:v1
```

---

## ✅ Task-5: Image Best Practices

### Optimized Production Dockerfile
```dockerfile
FROM node:18-alpine

WORKDIR /app

RUN addgroup appgroup && adduser -S appuser -G appgroup

COPY package.json .
RUN npm install --only=production

COPY app.js .

USER appuser

EXPOSE 3000

CMD ["node","app.js"]
```

### Improvements Applied
- Minimal base image  
- Non-root container execution  
- Reduced image layers  
- Production-only dependencies  
- Fixed version tag for reproducible builds  

---

## 🚀 Key DevOps Learnings

- Multi-stage builds drastically reduce image size  
- Smaller images improve CI/CD speed and deployment reliability  
- Running containers as non-root improves security  
- Docker Hub enables global image distribution  
- Tagging strategy helps version control and rollback  

---

## 🧠 Outcome

Built and published a **production-optimized container image** using multi-stage Docker builds and Docker Hub distribution, simulating real DevOps delivery workflows.