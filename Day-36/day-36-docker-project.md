# Day 36 – Docker Project: Dockerize a Full Application

---

## Task 1 – Pick Your App

I selected a **DevOps Notes Dashboard** full-stack application.

This app allows users to create and delete operational notes from a web UI.

Reason for choosing:

- Demonstrates real DevOps internal tooling use-case  
- Requires frontend + backend + database architecture  
- Shows reverse proxy networking  
- Supports persistent storage  
- Suitable for real deployment workflow practice  

Architecture:

Browser → Nginx → Flask API → PostgreSQL → Docker Volume

---

## Task 2 – Write the Dockerfile

Backend application was containerized using a lightweight image.

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -m appuser
USER appuser

EXPOSE 5000

CMD ["python","app.py"]
```

### .dockerignore

```
__pycache__
*.pyc
.git
.env
*.log
```

The image was built and tested locally using:

```
docker build -t devops-notes .
docker run -p 5000:5000 devops-notes
```

---

## Task 3 – Add Docker Compose

Multi-container system was created.

```yaml
services:

  nginx:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./frontend:/usr/share/nginx/html
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - backend
    networks:
      - notesnet

  backend:
    image: fahim017803/devops-notes:v1
    env_file:
      - .env
    depends_on:
      db:
        condition: service_healthy
    networks:
      - notesnet

  db:
    image: postgres:16-alpine
    env_file:
      - .env
    volumes:
      - notesdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL","pg_isready -U postgres"]
      interval: 5s
      timeout: 3s
      retries: 5
    networks:
      - notesnet

volumes:
  notesdata:

networks:
  notesnet:
```

Environment variables:

```
DB_HOST=db
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=notesdb

POSTGRES_DB=notesdb
POSTGRES_PASSWORD=postgres
```

System tested using:

```
docker compose up
```

---

## Task 4 – Ship It

Image was tagged and pushed to Docker Hub.

```
docker tag devops-notes fahim017803/devops-notes:v1
docker push fahim017803/devops-notes:v1
```

Docker Hub Image:

```
fahim017803/devops-notes:v1
```

README created explaining:

- project purpose  
- how to run with docker compose  
- required environment variables  

---

## Task 5 – Test the Whole Flow

All local images and containers were removed.

Fresh deployment tested using:

```
docker pull fahim017803/devops-notes:v1
docker compose up
```

Application successfully ran on a new server using only compose configuration.

---

## Challenges Faced

- Container networking issue (localhost vs service name)
- Reverse proxy API routing configuration
- Database data loss after restart
- Correct Docker image publishing workflow
- Fresh deployment validation

Solutions included:

- Using internal Docker network
- Configuring Nginx proxy rules
- Attaching named volume
- Testing deployment on clean environment

---

## Final Image Size

Approx:

```
~140 MB
```

---

## Key Learning Outcome

This task demonstrated real DevOps workflow:

Build → Containerize → Push → Deploy → Run Anywhere

It improved understanding of:

- Docker image lifecycle  
- multi-container orchestration  
- reverse proxy architecture  
- portable infrastructure setup  
