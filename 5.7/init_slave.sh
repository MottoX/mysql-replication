#!/bin/bash

# set basic master info
mysql -uroot -e "RESET MASTER; \
    CHANGE MASTER TO \
    MASTER_HOST='$MASTER_HOST', \
    MASTER_PORT=$MASTER_PORT, \
    MASTER_USER='$REPLICATION_USER', \
    MASTER_PASSWORD='$REPLICATION_PASSWORD';"

# dump data from master to slave

mysqldump \
    --host=$MASTER_HOST \
    --port=$MASTER_PORT \
    --user=root \
    --protocol=tcp \
    --master-data=1 \
    --add-drop-database \
    --flush-logs \
    --flush-privileges \
    --all-databases \
    | mysql -uroot

#mysql -uroot -p${MYSQL_ROOT_PASSWORD} < master.dump
#rm master.dump

# start slave
mysql -uroot -e "START SLAVE;"
