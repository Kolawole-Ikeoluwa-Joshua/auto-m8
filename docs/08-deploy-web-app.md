# Jenkins + Ansible: Deploy Simple Web Application

### Create a MySQL Database service

Create a `db_data` directory in the jenkins directory on host machine.

Modify the [docker-compose](https://github.com/Kolawole-Ikeoluwa-Joshua/auto-m8/blob/606231e853a57762e7cb6c8f28923b016ccc084a/scripts/docker-compose.yml) file, by adding a new database service.

Create the database container
```
docker-compose up -d
```

#### Create a Database and Populate it
- Generate a text file with [random](https://github.com/Kolawole-Ikeoluwa-Joshua/auto-m8/blob/main/scripts/db_host/random-name.txt) names in `jenkins-ansible` directory.

- Create a Database that will store list of random usernames

* connect to the database container 
```
docker exec -ti db bash
```
* log into mysql to create database
```
mysql -u root -p
```
* create a mysql database
```
create database people;
use people;
create table register (id int(3), name varchar(50), lastname varchar(50), age int(3));

show tables;
desc register;
```
![people-db](https://github.com/Kolawole-Ikeoluwa-Joshua/auto-m8/blob/main/docs/images/people%20database.png)


- Create a shell [script](https://github.com/Kolawole-Ikeoluwa-Joshua/auto-m8/blob/main/scripts/db_host/populate-db.sh) to populate database.

Note: make sure the script is executable `chmod +x populate-db.sh`

- Populate Database service using shell script

* copy the shell script and text file to the database container
```
docker cp populate-db.sh db:/tmp

docker cp people.txt db:/tmp
```
* log into the database container and execute the shell scrip
```
cd /tmp

./populate-db.sh
```
* log into database to verify the data has been added
```
use people;
show tables;
select * from register;
```
![populated-db](https://github.com/Kolawole-Ikeoluwa-Joshua/auto-m8/blob/main/docs/images/populated%20database.png)

### Create a Nginx Web Server service