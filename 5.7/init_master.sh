#!/bin/bash

# create user for replication
mysql -uroot -e "GRANT \
    REPLICATION SLAVE, \
    REPLICATION CLIENT \
    ON *.* \
    TO '$REPLICATION_USER'@'%' \
    IDENTIFIED BY '$REPLICATION_PASSWORD'; \
    FLUSH PRIVILEGES;"

