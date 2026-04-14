# Day 37 – Docker Revision

## ✅ Self-Assessment

| Topic | Status |
|------|--------|
| Run container | can do |
| Manage containers/images | can do |
| Image layers & caching | shaky |
| Dockerfile basics | can do |
| CMD vs ENTRYPOINT | shaky |
| Build & tag image | can do |
| Volumes | can do |
| Bind mounts | can do |
| Networks | shaky |
| Docker Compose | can do |
| Env variables | can do |
| Multi-stage builds | shaky |
| Push to Docker Hub | can do |
| Healthchecks | shaky |

---

## ⚡ Quick-Fire Answers

**1. Image vs Container**  
Image = blueprint (read-only)  
Container = running instance of that image  

**2. Data after container removal**  
Lost unless stored in volume/bind mount  

**3. Communication in same network**  
Containers use service name as hostname  

**4. docker compose down vs down -v**  
down → stops containers  
down -v → also deletes volumes (data loss)  

**5. Multi-stage builds**  
Reduce image size by separating build + runtime  

**6. COPY vs ADD**  
COPY = simple file copy  
ADD = copy + extra features (URL, auto extract)  

**7. -p 8080:80**  
Host port 8080 → container port 80  

**8. Check Docker disk usage**  
docker system df  

---

## 🔥 Weak Areas to Improve

1. Image layers & caching  
2. CMD vs ENTRYPOINT  

---

## 🔁 Action Taken

- Rebuilt Dockerfile multiple times to observe caching  
- Tested CMD vs ENTRYPOINT behavior using simple scripts  

---

## 📌 Key Learnings

- Layer caching = huge performance gain  
- ENTRYPOINT locks command, CMD is override-able  
- Volumes = critical for real apps (data persistence)  
- Compose = must for multi-container systems  
