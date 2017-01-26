# mysql-replication
A custom docker image with replication enabled.

## Introduction
The image is based on official [mysql-server](https://hub.docker.com/r/mysql/mysql-server/) with replication enabled
for the purpose of learning mysql.

### Environment Variables
**REPLICATION_USER**  
The user name for replication.

**REPLICATION_PASSWORD**  
The password of replication user.

**SERVER_ID**  
Make sure every node has a **different** server id.

## Getting Started
1. Download the image
    ```sh
    docker pull mottox/mysql-replication
    ```

2. Run master node with
    ```sh
    docker run --name master -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e SERVER_ID=1 -d mottox/mysql-replication
    ```

3. Run slave node with
    ```sh
    docker run --name slave -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e SERVER_ID=2 --link master:replication -d mottox/mysql-replication
    ```

4. Check if replication is ready
   ```sh
   docker exec -it slave mysql -e 'show slave status\G'
   ```
   The expected `Slave_IO_State` should be `Waiting for master to send event`.

5. Test replication

## Inspiration
[official mysql image](https://github.com/docker-library/mysql)  
[docker-mysql-replication](https://github.com/bergerx/docker-mysql-replication)  
[High Performance MySQL](http://www.highperfmysql.com/)
