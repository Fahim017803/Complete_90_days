# Day-33 — Docker Compose (Multi-Container Basics)

## Objective
Run multi-container applications using Docker Compose instead of manually creating containers, networks and volumes.

---

## Task-1 — Install & Verify Compose

Check version:

docker compose version

If not installed:

sudo apt update  
sudo apt install docker-compose-plugin -y  

Verify again:

docker compose version

---

## Task-2 — Single Container (Nginx)

Create directory:

mkdir compose-basics  
cd compose-basics  

Create docker-compose.yml:

services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"

Run:

docker compose up -d  

Verify:

http://EC2_PUBLIC_IP:8080  

Stop:

docker compose down  

---

## Task-3 — Multi-Container (WordPress + MySQL)

docker-compose.yml:

services:

  db:
    image: mysql:8
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wppass
    volumes:
      - db_data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    restart: always
    ports:
      - "8081:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wppass
      WORDPRESS_DB_NAME: wordpress
    depends_on:
      - db

volumes:
  db_data:

Run stack:

docker compose up -d  

Open:

http://EC2_PUBLIC_IP:8081  

Complete WordPress setup.

Persistence test:

docker compose down  
docker compose up -d  

Site data remains → volume working.

---

## Task-4 — Compose Commands Practice

docker compose up -d  
docker compose ps  
docker compose logs -f  
docker compose logs -f wordpress  
docker compose stop  
docker compose start  
docker compose down  
docker compose up -d --build  

---

## Task-5 — Environment Variables (.env)

Create .env file:

MYSQL_ROOT_PASSWORD=rootpass  
MYSQL_DATABASE=wordpress  
MYSQL_USER=wpuser  
MYSQL_PASSWORD=wppass  

Use in compose:

environment:
  MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
  MYSQL_DATABASE: ${MYSQL_DATABASE}
  MYSQL_USER: ${MYSQL_USER}
  MYSQL_PASSWORD: ${MYSQL_PASSWORD}

Verify:

docker compose config  

---

## Key Learnings

- Multi-container deployment using Docker Compose  
- Automatic network and service DNS  
- Named volume persistence  
- Container lifecycle management  
- Environment variable configuration  
- Infrastructure as Code mindset  

---

#90DaysOfDevOps #Docker #DevOps