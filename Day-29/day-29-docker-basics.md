# 🚀 Day 29 – Docker Basics

## 🐳 What is Docker?

Docker is a platform to run applications inside containers.

### What is a Container?
A lightweight isolated environment that runs an app with its dependencies.

Container = App + Dependencies + Isolated Process

---

## 🆚 Containers vs VMs

| Containers | Virtual Machines |
|------------|------------------|
| Share OS kernel | Full OS |
| Fast start | Slow start |
| Lightweight | Heavy |

VM = Full OS  
Container = Process

---

## 🏗 Docker Architecture

User → Docker CLI → Docker Daemon → Image → Container  
Images stored in Docker Hub.

Image = Blueprint  
Container = Running instance

---

# 🛠 Install & Verify

```bash
docker --version
docker run hello-world
```

Hello-world:
- Pull image
- Run container
- Print message
- Exit

---

# 🧪 Run Real Containers

## Nginx

```bash
docker run -d -p 8080:80 --name mynginx nginx
docker ps
sudo ufw status
sudo ufw enable 
```

```bash
Check security group
Edit Inbound rules
add Host port number
'''

Browser:
```
http://<PUBLIC-IP>:8080
```

---

## Ubuntu Interactive

```bash
docker run -it ubuntu bash
```

Exit:
```
exit
```

---

## Manage Containers

```bash
docker ps
docker ps -a
docker stop mynginx
docker rm mynginx
docker logs mynginx
docker exec -it mynginx bash
```

---

# 🔥 Why Docker Matters

- Used in CI/CD
- Used in Kubernetes
- Used in cloud deployments

Docker = Foundation of modern DevOps.

---

# ✅ Day 29 Completed
Docker installed ✔  
Container running ✔  
Nginx deployed ✔  
Commands practiced ✔  
