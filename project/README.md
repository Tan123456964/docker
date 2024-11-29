#1 build and run docker images 
```bash
docker compose up --build
```
#2 check volume data 
```bash
# Start the MySQL container
docker run -d --name mysqlserver \
    -e MYSQL_ROOT_PASSWORD=rootpassword \
    -e MYSQL_DATABASE=onlinestore \
    -e MYSQL_USER=appuser \
    -e MYSQL_PASSWORD=apppassword \
    -v project_data:/var/lib/mysql \
    mysql:latest

# Wait for MySQL to be ready
until docker exec mysqlserver mysql -uappuser -papppassword -e "SELECT 1" onlinestore &> /dev/null; do
    echo "Waiting for MySQL to be ready..."
    sleep 5
done

# Display contents of all tables in the onlinestore database
tables=$(docker exec mysqlserver mysql -uappuser -papppassword -D onlinestore -e "SHOW TABLES;" | tail -n +2)
for table in $tables; do
    echo "Displaying contents of table: $table"
    docker exec mysqlserver mysql -uappuser -papppassword -D onlinestore -e "SELECT * FROM \`$table\`;"
done

```
#3 hostnetwork test

```bash
docker run --name hostweb1 --network host -e NGINX_PORT=5550 nginx:latest
docker run --name hostweb2 --network host -e NGINX_PORT=5550 nginx:latest

```