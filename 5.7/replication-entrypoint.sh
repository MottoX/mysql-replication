#!/bin/bash
set -eo pipefail

MYSQL_CNF_FILE="/etc/my.cnf"

if [ -n "$REPLICATION_MASTER_HOST" ]; then
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
