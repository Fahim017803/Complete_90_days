# Day 35 – Debugging Log (Multi-Stage Builds & Docker Hub)

## 🎯 Objective
Real troubleshooting notes while building optimized Docker images and pushing to Docker Hub.

---

## 🔴 Problem-1: package.json Not Found

**Error**
```
COPY failed: file not found in build context
```

**Cause**
Build command was executed from the wrong directory or file did not exist.

**Solution**
- Move into correct project folder
- Ensure required files exist

```
docker build -t image-name .
```

---

## 🔴 Problem-2: npm Command Not Found

**Error**
```
Command 'npm' not found
```

**Cause**
NodeJS runtime was not installed on the server.

**Solution**
```
sudo apt update
sudo apt install nodejs npm -y
```

---

## 🔴 Problem-3: Large Docker Image Size

**Issue**
Single-stage Docker build created very large image.

**Cause**
Build dependencies and runtime tools were bundled together.

**Solution**
Use multi-stage build:

```
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm install

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
CMD ["node","app.js"]
```

---

## 🔴 Problem-4: Docker Push Permission Denied

**Error**
```
denied: requested access to the resource is denied
```

**Cause**
- Docker Hub login session missing
- Using sudo docker caused different auth context
- Repo ownership mismatch

**Solution**
```
docker logout
docker login
docker push username/image:v1
```

---

## 🔴 Problem-5: Image Tag Not Found

**Error**
```
An image does not exist locally with the tag
```

**Cause**
Local image name and Docker Hub repo name did not match.

**Solution**
```
docker tag local-image username/repo:v1
```

---

## 🔴 Problem-6: Multi-Stage Concept Confusion

**Issue**
Both stages looked similar.

**Learning**
- Stage-1 → build environment
- Stage-2 → minimal runtime environment
- Build tools are excluded → image becomes smaller and more secure

---

## 🔴 Problem-7: Running Container as Root

**Issue**
Default container user was root → production security risk.

**Solution**
```
RUN addgroup appgroup && adduser -S appuser -G appgroup
USER appuser
```

---

## 🔴 Problem-8: Image Optimization Strategy

**Best Practices Applied**
- Used alpine base image
- Reduced unnecessary layers
- Used specific image tags instead of latest
- Installed only required dependencies
- Cleaned build artifacts

---

## ✅ Final DevOps Learning

Day-35 core skills:

- Multi-stage image optimization
- Docker Hub authentication workflow
- Image tagging and registry push
- Build context troubleshooting
- Production container security practices

Real DevOps skill develops by debugging real deployment failures.