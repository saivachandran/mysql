CentOS MySQL Master-Slave Replication – Step by Step

website: https://bobbyiliev.com/blog/centos-mysql-master-slave-replication-step-by-step/


MySQL replication is a process that enables data from one MySQL database server (the master) to be copied automatically to one or more MySQL database servers (the slaves).

I would assume that you have MySQL installed on both servers, so we would get straight into the Master-Slave setup.

I would use the following two servers:

192.168.1.44 – Master
192.168.1.4 – Slave


1. We are going to start with the master:

– SSH to the master server

– Edit the /etc/my.cnf file

vi /etc/my.cnf

	
Add the following entries under [mysqld] section and don’t forget to replace the database name with database name that you would like to replicate on Slave.

server-id = 1
binlog-do-db=san
relay-log = /var/lib/mysql/mysql-relay-bin
relay-log-index = /var/lib/mysql/mysql-relay-bin.index
log-error = /var/lib/mysql/san.err
master-info-file = /var/lib/mysql/mysql-master.info
relay-log-info-file = /var/lib/mysql/mysql-relay-log.info
log-bin = /var/lib/mysql/mysql-bin

Restart mysql

#systemctl restart mysqld

--> Create the replication user (change the Pass-Goes-Here part with your new pass)
--> – Note this goes on the slave, so that the master could then connect to the slave server

Login Mysql

 mysql> GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'Pass-Goes-Here';
 mysql> FLUSH PRIVILEGES;

we have to export the database that we would like to replicate.

Open a second SSH session

In the first session run:

mysql>FLUSH TABLES WITH READ LOCK;

mysql>SHOW MASTER STATUS;

------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000003 | 11128001 | my_database  |                  |
+------------------+----------+--------------+------------------+
1 row in set (0.00 sec)


Take a note of the the File (mysql-bin.000003) and Position (11128001) numbers

While the tables have been locked with the read lock – go ahead and export the database in question via the Second SSH session without closing the first one!
mysqldump my_database > /root/my_database.sql 
1
	
mysqldump san > /root/san.sql 

Once that has been done unlock the tables via the first ssh session
 mysql> UNLOCK TABLES;
 mysql> quit;

	
  Now we are ready to start with the slave setup. Go ahead and copy the dump from the master to the slave

scp /root/san.sql root@192.168.1.2:/root/

Then SSH to the slave server.

– Edit the my.cnf:

vim /etc/my.cnf

Under the [mysqld] section add the following and update the details accordingly:

server-id = 2
replicate-do-db=san
relay-log = /var/lib/mysql/mysql-relay-bin
relay-log-index = /var/lib/mysql/mysql-relay-bin.index
log-error = /var/lib/mysql/san.err
master-info-file = /var/lib/mysql/mysql-master.info
relay-log-info-file = /var/lib/mysql/mysql-relay-log.info
log-bin = /var/lib/mysql/mysql-bin


Now import the dump file that we exported in earlier command and restart the MySQL service.
mysql -u my_database -p < /root/my_database.sql
1
	
mysql -u my_database -p < /root/my_database.sql

Note you might need to create the database before importing the data:
mysql
CREATE DATABASE my_database;
	
mysql
CREATE DATABASE san;

Login into MySQL as root user and stop the slave:
	
mysql> stop slave;

Then in order to start the replication run the following and make sure th update the details accordingly:

mysal>CHANGE MASTER TO MASTER_HOST='192.168.1.4', MASTER_USER='saiva', MASTER_PASSWORD='Saiva@123', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=1539;

start slave;
show slave status\G

After complete make change in master sql check on slave server
