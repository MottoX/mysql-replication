FROM mysql/mysql-server:5.7
MAINTAINER Robin Wang<micrari@gmail.com>

ENV SERVER_ID=1
ENV REPLICATION_USER=repl
ENV REPLICATION_PASSWORD=test
ENV REPLICATION_MASTER_HOST=

COPY replication-entrypoint.sh \
     master.cnf \
     init_master.sh \
     slave.cnf \
     init_slave.sh \
     /

ENTRYPOINT ["sh", "/replication-entrypoint.sh"]
CMD ["mysqld"]
