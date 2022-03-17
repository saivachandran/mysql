
```
sudo systemctl stop mysql.service
 
 sudo systemctl status mysql.service
 
 sudo systemctl set-environment MYSQLD_OPTS="--skip-networking --skip-grant-tables"
 
 sudo systemctl start mysql.service
 
 sudo systemctl status mysql.service
 
 sudo mysql -u root
 
 flush privileges;
 
 USE mysql
 
 ALTER USER  'root'@'localhost' IDENTIFIED BY 'Saiva@123';
 
 quit;
 
 sudo killall -u mysql
 
 
 sudo systemctl restart mysql.service
 
 sudo mysql -u root -p
 
 ```
