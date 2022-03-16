#!/bin/bash
MYSQL_USER=root
MYSQL_PASSWORD="pass"
DB_user="user"
#PASS="pass"
MAINDB="v2"
#mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "CREATE USER ${DB_user}@'%' IDENTIFIED BY '${PASS}';"
for table in $(cat /var/scripts/file.txt); do
    mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "GRANT SELECT ON ${MAINDB}.${table} TO '${DB_user}'@'%';"
    mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "FLUSH PRIVILEGES;"
done
