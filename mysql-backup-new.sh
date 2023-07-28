cdate=$(date '+%Y%m%d_%H%M')
bdate=$(date '+%Y%m%d_%H')
filename="mysqldata-${cdate}.tar.gz"

rm -f /mysqlbackup/mysqldata-*.gz
rm -f /mysqlbackup/db1*.gz
rm -f /mysqlbackup/sdb2*.gz
rm -f /mysqlbackup/db3*.gz

{
        for i in db1 db2 db3
        do
                echo "[ $i ] database dump Started at $(date '+%Y%m%d-%T' )" 1>> $logfile 2>&1
                mysqldump -u root -p'pass' --routines --quick --skip-lock-tables --single-transaction --databases $i | gzip > /mysqlbackup/${i}_${bdate}.sql.gz
        done
	tar -zcvf /mysqlbackup/mysqldata-${cdate}.tar.gz -C /mysqlbackup/ db1_${bdate}.sql.gz db2_${bdate}.sql.gz db3_${bdate}.sql.gz
	sleep 5
        aws s3 cp /mysqlbackup/${filename} s3://databackup/

	echo " mysql backup copied to s3" | mail -s "mysqlbackup" xxy@gmail.com
}

}
