#!/bin/bash
set -eo pipefail

MYSQL_CNF_FILE="/etc/my.cnf"

if [ -n "$MASTER_PORT_3306_TCP_ADDR" ]; then
    export MASTER_HOST=$MASTER_PORT_3306_TCP_ADDR
    export MASTER_PORT=$MASTER_PORT_3306_TCP_PORT
fi

if [ $REPLICATION_ROLE = "master" ]; then
    mv /master.cnf  ${MYSQL_CNF_FILE}
elif [ $REPLICATION_ROLE = "slave" ]; then
    mv slave.cnf ${MYSQL_CNF_FILE}
fi

exec /entrypoint.sh "$@"
