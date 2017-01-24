FROM mysql/mysql-server:5.7
MAINTAINER MottoX <micrari@gmail.com>

ENV REPLICATION_ROLE slave

COPY replication-entrypoint.sh \
     master.cnf \
     slave.cnf \
     /
RUN chmod +x /replication-entrypoint.sh

ENTRYPOINT ["/replication-entrypoint.sh"]
CMD ["mysqld"]
