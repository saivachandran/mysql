# copy remote mysqlbackup into localmachine
------------------------------------------

ssh -f -L3310:localhost:3306 ubuntu@slave -N



mysqldump -P 3310 -h 127.0.0.1 -u root -p --skip-lock-tables --quick --single-transaction  --all-databases  > all_databases.sql
