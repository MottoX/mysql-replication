FROM mysql/mysql-server:5.7
MAINTAINER MottoX <micrari@gmail.com>

ENV REPLICATION_ROLE slave
ENV REPLICATION_USER repl
ENV REPLICATION_PASSWORD test

COPY replication-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/replication-entrypoint.sh

ENTRYPOINT ["replication-entrypoint.sh"]
CMD ["mysqld"]
