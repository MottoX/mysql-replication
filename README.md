# mysql-replication
A custom mysql docker image with replication enabled, easy and convenient to set up MySQL master-slave replication in 30 seconds.

## Introduction
The image is based on official [mysql-server](https://hub.docker.com/r/mysql/mysql-server/) with replication enabled
for the purpose of learning mysql. Note that this image is for people who want to learn and practice MySQL replication in an easy way.

### Environment Variables
**SERVER_ID**  
Make sure every node has a **different** server id.

**REPLICATION_USER**  
The user name for replication.

**REPLICATION_PASSWORD**  
The password of replication user.

## Getting Started
1. Download the image
    ```sh
    docker pull mottox/mysql-replication
    ```
   Alternatively, you could also clone this repository and build the image locally.

2. Run master node with
    ```sh
    docker run \
    --name master \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    -e MYSQL_ROOT_HOST=% \
    -e SERVER_ID=1 \
    -d mottox/mysql-replication
    ```

   And then Run slave node with
    ```sh
    docker run \
    --name slave \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    -e MYSQL_ROOT_HOST=% \
    -e SERVER_ID=2 \
    -e REPLICATION_MASTER_HOST=master \
    --link master:replication   \
    -d mottox/mysql-replication
    ```
    
   Instead of run the two commands above, you could also copy and use the `docker-compose.yml` configuration file 
   and run `docker-compose up` to set up master-slave replication.
3. Check if replication is ready
   ```sh
   docker exec -it slave mysql -e 'show slave status\G'
   ```
   The expected `Slave_IO_State` should be `Waiting for master to send event`.

4. Test replication freely

## Inspiration
[official mysql image](https://github.com/docker-library/mysql)  
[docker-mysql-replication](https://github.com/bergerx/docker-mysql-replication)  
[High Performance MySQL](http://www.highperfmysql.com/)
