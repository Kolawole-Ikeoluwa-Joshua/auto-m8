# Jenkins + Ansible: Deploy Simple Web Application

### Create a MySQL Database service

Create a `db_data` directory in the jenkins directory on host machine.

Modify the [docker-compose](/scripts/docker-compose.yml) file, by adding a new database service.

Create the database container
```
docker-compose up -d
```

#### Create a Database and Populate it
- Generate a text file with [random](/scripts/db_host/people.txt) names in `jenkins-ansible` directory.

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
![people-db](./images/people%20database.png)


- Create a shell [script](/scripts/db_host/populate-db.sh) to populate database.

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
![populated-db](./images/populated%20database.png)

### Create Nginx & PHP-FPM services

Create a `web` directory in the `jenkins-ansible` directory on host machine. Navigate into the `web` directory.

Create a [Dockerfile](/scripts/web/Dockerfile) for the nginx.

Create a `conf` directory to store a nginx configuration file [default.conf](/scripts/web/default.conf).

Note: fpm receives the full path from nginx and tries to find the files in the fpm container, so it must be the exactly the same as server.root in the nginx config.

Create a `data-html` directory in the `jenkins` directory on the host machine, this directory will serve as shared volume to the
php-fpm container.

Create services for both nginx and php-fpm in the [docker-compose](/scripts/docker-compose.yml) file.

Start the services with these commands:
```
docker-compose build

docker-compose up -d
```
#### Verification

Navigate to the root directory of the web server `cd data-html`

Create a php [index](/scripts/web/index.php) file to output information about PHP's configuration in that directory.

![php-ouput](./images/php%20info%20page.png)


### Display Random User Data on Webpage
In this section, create a jinja2 template that uses HTML, CSS, PHP to display Database content on the websites index page

#### prerequisite

Ensure the `php-fpm` container has a `mysqli` extension installed in it.

```

docker exec -ti jenkins_fpm_1 bash          #log into the fpm container

docker-php-ext-install mysqli 

docker-php-ext-enable mysqli

docker restart jenkins_fpm_1        #log out, and then restart the container

```
access your website using your web browser, you should see the mysqli configuration details below:

![mysqli](./images/install%20mysqli%20extension.png)

#### Update the website index page

Copy the content of [table.j2](/scripts/web/table.j2) jinja template into the `index.php` file in the `data-html` directory.

access your website using your web browser, notice the website is now displaying user with age 25 as 

defined in the jinja template.

![website-data](./images/website%20data%20using%20jinja.png)