
#1 build and run docker images 
```bash
docker compose up --build
# URL: https://localhost:443 or https://localhost
```
#2 run init.sql in ec2 admin instance 

```bash
# once you have ec2 instance and rds running, ssh to admin instance, copy over init.sql and run this file against RDS

# ssh to admin instance 
ssh -i secreat.pem ec2-user@ec2-44-212-71-218.compute-1.amazonaws.com
# open init.sql file with vim and copy and paste content of init.sql 
vim init.sql 
# initilize rds 
mysql -h <rds-domain-name> -u <user> -p'<password>' < init.sql

# verfiy db is initilaized 
mysql -h <rds-domain-name> -u <user> -p'<password>'
show databases;
use project;
show tables;
select * from cat;

```