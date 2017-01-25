#!/bin/bash
set -eo pipefail

MYSQL_CNF_FILE="/etc/my.cnf"

if [ -n "$REPLICATION_PORT_3306_TCP_ADDR" ]; then
    export MASTER_HOST=$REPLICATION_PORT_3306_TCP_ADDR
    export MASTER_PORT=$REPLICATION_PORT_3306_TCP_PORT

    cp slave.cnf ${MYSQL_CNF_FILE}

    cp init_slave.sh /docker-entrypoint-initdb.d/
else
    cp master.cnf  ${MYSQL_CNF_FILE}
    
    cp init_master.sh /docker-entrypoint-initdb.d/
fi

cat > /etc/my.cnf.d/server-id.cnf << EOF
[mysqld]
server-id=$SERVER_ID
EOF

exec /entrypoint.sh "$@"
