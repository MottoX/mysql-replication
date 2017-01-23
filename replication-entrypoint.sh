#!/bin/bash
set -eo pipefail

MYSQL_CNF_FILE="/etc/my.cnf"

if [ -n "$MASTER_PORT_3306_TCP_ADDR" ]; then
    export MASTER_HOST=$MASTER_PORT_3306_TCP_ADDR
    export MASTER_PORT=$MASTER_PORT_3306_TCP_PORT
fi

if [ $REPLICATION_ROLE = "master" ]; then
    cat > ${MYSQL_CNF_FILE}  << 'EOF'
    [mysqld]
    log_bin=mysql-bin
    server-id=1

    # join_buffer_size = 128M
    # sort_buffer_size = 2M
    # read_rnd_buffer_size = 2M
    skip-host-cache
    skip-name-resolve
    datadir=/var/lib/mysql
    socket=/var/lib/mysql/mysql.sock
    secure-file-priv=/var/lib/mysql-files
    user=mysql

    # Disabling symbolic-links is recommended to prevent assorted security risks
    symbolic-links=0

    log-error=/var/log/mysqld.log
    pid-file=/var/run/mysqld/mysqld.pid
EOF
elif [ $REPLICATION_ROLE = "slave" ]; then
    cat > ${MYSQL_CNF_FILE}  << 'EOF'
    [mysqld]
    log_bin=mysql-bin
    server-id=2

    # join_buffer_size = 128M
    # sort_buffer_size = 2M
    # read_rnd_buffer_size = 2M
    skip-host-cache
    skip-name-resolve
    datadir=/var/lib/mysql
    socket=/var/lib/mysql/mysql.sock
    secure-file-priv=/var/lib/mysql-files
    user=mysql

    # Disabling symbolic-links is recommended to prevent assorted security risks
    symbolic-links=0

    log-error=/var/log/mysqld.log
    pid-file=/var/run/mysqld/mysqld.pid
EOF
fi

exec /entrypoint.sh "$@"
