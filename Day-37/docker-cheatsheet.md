# Docker Cheat Sheet

## 🔹 Containers
docker run -it ubuntu bash          # Run interactive container
docker run -d -p 8080:80 nginx      # Run detached with port mapping
docker ps                           # List running containers
docker ps -a                        # List all containers
docker stop <id>                    # Stop container
docker rm <id>                      # Remove container
docker exec -it <id> bash           # Access running container
docker logs <id>                    # View logs

## 🔹 Images
docker build -t myapp .             # Build image
docker images                       # List images
docker rmi <id>                     # Remove image
docker pull nginx                   # Pull image from Docker Hub
docker push myrepo/myapp            # Push image
docker tag myapp user/myapp:latest  # Tag image

## 🔹 Volumes
docker volume create myvol          # Create volume
docker volume ls                    # List volumes
docker volume inspect myvol         # Inspect volume
docker volume rm myvol              # Remove volume

## 🔹 Bind Mounts
docker run -v $(pwd):/app nginx     # Mount local folder

## 🔹 Networks
docker network create mynet         # Create network
docker network ls                   # List networks
docker network inspect mynet        # Inspect network
docker network connect mynet <id>   # Connect container

## 🔹 Docker Compose
docker compose up -d                # Start services
docker compose down                # Stop services
docker compose down -v             # Remove volumes too
docker compose ps                  # List services
docker compose logs -f             # View logs
docker compose build              # Build services

## 🔹 Cleanup
docker system prune -a             # Remove unused everything
docker volume prune                # Remove unused volumes
docker system df                   # Disk usage

## 🔹 Dockerfile
FROM python:3.10                   # Base image
WORKDIR /app                       # Set working dir
COPY . .                           # Copy files
RUN pip install -r requirements.txt # Install deps
EXPOSE 5000                        # Expose port
CMD ["python", "app.py"]           # Default command
ENTRYPOINT ["python"]              # Fixed command
