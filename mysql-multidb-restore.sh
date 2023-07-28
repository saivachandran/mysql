#!/bin/bash

sh extract.sh

# Variables for the script
BACKUP_DIR='/mysqldata/'
MYSQL_USER='user'
MYSQL_PASSWORD='pass'

# Loop through the backup files in the directory
for file in $BACKUP_DIR/*.sql; do
    # Get the database name from the file name
    DATABASE_NAME=$(basename $file .sql)

    # Restore the database from the backup file
    mysql -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE_NAME < $file

    # Confirm that the restore was successful
    if [ $? -eq 0 ]; then
        echo "The $DATABASE_NAME has been successfully restored from the backup file."
    else
        echo "An error occurred while restoring the $DATABASE_NAME."
    fi
done
