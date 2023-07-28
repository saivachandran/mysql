MYSQL_USER=user
MYSQL_PASSWORD="pass"
server_name=$(hostname)
#
# Set the maximum number of seconds behind master that will be ignored. 
# If the slave is be more than maximumSecondsBehind, an email will be sent. 
#
#maximumSecondsBehind=60
#
# Checking MySQL replication status...
#
mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e 'SHOW SLAVE STATUS \G' | grep 'Running:\|Master:\|Error:' > replicationStatus.txt 
#
# displaying results, just in case you want to see them 
#
#echo "Results:"
#cat replicationStatus.txt
#
# checking parameters
#
slaveRunning=$(cat replicationStatus.txt| grep -i "Slave_IO_Running: Yes"| wc -l)
slaveSQLRunning=$(cat replicationStatus.txt | grep "Slave_SQL_Running: Yes" | wc -l)
#secondsBehind=$(cat replicationStatus.txt | grep "Seconds_Behind_Master: 0" | wc -l)
#echo $slaveRunning

   if  [ "$slaveRunning" != 1 -o $slaveSQLRunning != 1  ]; then  
   
   
     echo "$server_name mysql replication issue found" | mail -s "Mysql Replication alert $server_name" xyz@gamil.com, xxx@gmail.com, ghh@gmail.com   < replicationStatus.txt


  #else
  
    #echo "replication looks fine"



   fi 
