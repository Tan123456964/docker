
# Project Component (WIP)

> **TL;DR:** Learning Terraform by implementing a full-stack website. Work in progress.

1. **appserver**  
2. **webserver**  
3. **MySQL container** and `init.sql`  
4. **Terraform IaC**
   - **VPC**: NAT Gateway, public and private subnets, route tables, security groups  
   - **RDS Instance**: Single-AZ MySQL  
   - **EC2 instance**: Used to initialize RDS DB  
   - **ALB**: Internet-facing Application Load Balancer  
   - **ECS Fargate Deployment**  
   - **Route 53**
5. **Docker**: Building images and running the website locally  
   - `compose.yml`  
   - `Dockerfile`
6. **GitHub**: Source code management

# Build and Run Docker Images

```bash
docker compose up --build
# Access the app:
# URL: https://localhost:443 or https://localhost
```

# Run init.sql in ec2 admin instance 

```bash
# Once EC2 and RDS are running, SSH into the admin instance:
ssh -i <your-key.pem> ec2-user@<your-ec2-public-ip-or-dns>

# Open init.sql with vim and paste the content if not already copied:
vim init.sql

# Initialize RDS:
mysql -h <rds-domain-name> -u <user> -p'<password>' < init.sql

# Verify DB is initialized:
mysql -h <rds-domain-name> -u <user> -p'<password>'
show databases;
use project;
show tables;
select * from cat;

```
# Upload docker image to docker egistry
```bash
# Log in to Docker Hub
docker login
# Tag the Docker image
docker tag <local-image-name>:<local-tag> <dockerhub-username>/<repository-name>:<target-tag>
# Push the image
docker push <dockerhub-username>/<repository-name>:<target-tag>
```
