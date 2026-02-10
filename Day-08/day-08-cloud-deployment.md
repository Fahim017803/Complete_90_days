# Day 08 — Cloud Server Setup: Docker, Nginx & Web Deployment

Today I deployed a real cloud server and hosted a live web server accessible from the internet. This hands-on exercise helped me understand practical server management and cloud infrastructure.

--------------------------------------------------

## Commands Used

### SSH into Server
chmod 400 your-key.pem  
ssh -i your-key.pem ubuntu@<public-ip>

---

### Update System
sudo apt update && sudo apt upgrade -y  

---

### Install Docker
sudo apt install docker.io -y  
sudo systemctl start docker  
sudo systemctl enable docker  

---

### Install Nginx
sudo apt install nginx -y  
sudo systemctl start nginx  
sudo systemctl enable nginx  

---

### Verify Service
systemctl status nginx  

---

### View Logs
cd /var/log/nginx  
ls  

---

### Save Logs
sudo cp /var/log/nginx/access.log ~/nginx-logs.txt  

---

### Download Logs Locally
### Save Logs

Initially, I copied the log file using sudo:

sudo cp access.log ~/nginx-logs.txt  

However, this created a permission issue because the file was owned by the root user, preventing SCP from downloading it.

To resolve this properly, I copied the file using the full path and then changed ownership:

sudo cp /var/log/nginx/access.log /home/ubuntu/nginx-logs.txt  
sudo chown ubuntu:ubuntu /home/ubuntu/nginx-logs.txt  

This ensured the ubuntu user had permission to access the file.
then> scp -i your-key.pem ubuntu@<public-ip>:~/nginx-logs.txt .

### Run Nginx Using Docker

sudo docker run -d -p 8080:80 nginx  

This command launched an nginx container and mapped port 8080 on the server to port 80 inside the container.

After allowing port 8080 in the security group, I verified the deployment by accessing:

http://<public-ip>:8080


--------------------------------------------------

## Challenges Faced

**Issue:**  
The Nginx webpage was ––––not accessible initially.

**Cause:**  
Port 80 was blocked by the security group.

**Solution:**  
Updated inbound rules to allow HTTP traffic on port 80.

--------------------------------------------------

## What I Learned

- How to launch and connect to a cloud server using SSH  
- Importance of security groups in controlling traffic  
- Installing and managing services in a remote server  
- Extracting logs for troubleshooting  
- Making a web server publicly accessible  

--------------------------------------------------

## Why This Matters for DevOps

This exercise introduced real-world DevOps responsibilities such as:

- Cloud infrastructure provisioning  
- Remote server management  
- Web server deployment  
- Log handling  
- Basic cloud security  

It strengthened my confidence in working with production-style environments.
