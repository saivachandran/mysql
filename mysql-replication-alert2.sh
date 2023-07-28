MYSQL_USER=user
MYSQL_PASSWORD="pass"
server_name=$(hostname)
#
# Set the maximum number of seconds behind master that will be ignored. 
# If the slave is be more than maximumSecondsBehind, an email will be sent. 
#
#maximumSecondsBehind=5
#
# Checking MySQL replication status...
#
#mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e 'SHOW SLAVE STATUS \G' | grep 'Running:\|Master:\|Error:' > replicationLag.txt 
#
# displaying results, just in case you want to see them 
#
#echo "Results:"
#cat replicationStatus.txt
#
# checking parameters
#
#slaveRunning=$(cat replicationStatus.txt| grep -i "Slave_IO_Running: Yes"| wc -l)
#slaveSQLRunning=$(cat replicationStatus.txt | grep "Slave_SQL_Running: Yes" | wc -l)
#secondsBehind=$(cat replicationStatus.txt | grep "Seconds_Behind_Master: 0" | wc -l)
#echo $slaveRunning

SECONDS_BEHIND_MASTER=$(mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD}  -e "SHOW SLAVE STATUS\G"| grep "Seconds_Behind_Master" | awk '{ print $2 }')

   #echo $SECONDS_BEHIND_MASTER

  if [ "$SECONDS_BEHIND_MASTER" -gt 60 ]; then
  
   
     echo "$server_name The Slave is at least 60 seconds behind the master" | mail -s "Mysql Replication alert"  xyz@gmail.com    

 
  #else
  
    #echo "replication looks fine"



   fi 
