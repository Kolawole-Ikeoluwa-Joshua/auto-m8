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


### Automate Website Updates with Ansible:

#### Set up Ansible
Install ansible on your host machine:

```
sudo yum install -y epel-release

sudo yum install -y ansible
```

#### Set up python on FPM container

Log into the fpm container to set up python: 

```
docker exec -ti jenkins_fpm_1  bash

apt-get update

apt-get install -y python3-pip

```
#### Create an Ansible Playbook to update website table

Navigate to the `jenkins-ansible` directory, create the following:

* an ansible [playbook](/scripts/web/people.yml).
* edit the [hosts](/scripts/jenkins-ansible/hosts) file to have the following configurations.

#### Test the connection to the ansible host (FPM container)

Make sure you are in the directory with playbook & host file. Use the ping module to test connection.

```
ansible -m ping -i hosts jenkins_fpm_1
```
output:

![ansible-container](./images/ansible%20docker%20connection%20test.png)


#### Add Logic to filter website table

In the `jenkins-ansible` directory create a jinja template [table.j2](/scripts/web/table.j2). Notice the age filter added to the table.

#### Test the Ansible Playbook

Still in `jenkins-ansible` directory use ansible play to update the website table.

```
ansible-playbook -i hosts people.yml

```
output:

![playbook-update](./images/ansible%20playbook%20update%20site.png)

If you check the website you will notice the website displays all users in the database.

![display-update](./images/display%20update%20no%20filter.png)

To filter the users on the website by age run add a variable to the previous command.

```
ansible-playbook -i hosts people.yml -e "PEOPLE_AGE=25"
```
output:

![update-filter](./images/display%20update%20with%20filter.png)


### Automate Website Updates with Ansible & Jenkins:

#### Set up Docker in the Jenkins Container
Create a new directory `pipeline` and store the [Dockerfile](/scripts/pipeline/Dockerfile) for the ansible-docker-jenkins container.

Modify the [docker-compose](/scripts/pipeline/docker-compose.yml) file by adding the new jenkins service.

Build the new jenkins image with `docker-compose build`. Recreate the jenkins container with the new image `docker-compose up -d`.

Log into the jenkins container, test docker by viewing running containers `docker ps`. If you get the following error:

```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json": dial unix /var/run/docker.sock: connect: permission denied

```
On your Host machine, change the permissions for the `docker.sock` by giving jenkins access `sudo chown 1000:1000 /var/run/docker.sock`.

#### Create a Jenkins Job to Update Website

Log into Jenkins Dashboard, create a new freestyle project `ansible-automate`.

Complete the following configurations:

* Choice Parameters
![choice-param](./images/automate%20ansible%20choice%20parameter.png)

* Build Step to invoke ansible playbook. 
Note: Make sure the `hosts` inventory file, ansible playbook `people.yml` & the jinja `table.j2` template are in the 
`jenkins_home/ansible` directory. In the advanced section of the build step make sure to configure extra variables.

![build-step-1](./images/automate%20ansible%20choice%20build%201.png)

![build-step-2](./images/automate%20ansible%20choice%20build%202.png)


#### Build the Jenkins Job with Parameters

To update the website to display users of age `23` simple run the jenkins job `ansible-automate` with the right parameter.

![successful-job](./images/automate%20ansible%20successful.png)

Now from your browser check the website to see the update displayed.

![updated-website](./images/automate%20ansible%20website%20update.png)










