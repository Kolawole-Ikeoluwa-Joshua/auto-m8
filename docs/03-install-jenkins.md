# Setup Jenkins Service

### Install Jenkins

* Download the official jenkins image from docker hub:

`docker pull jenkins/jenkins`

* List docker images on host device:

`docker images`

* Locate docker path on host device

`docker info | grep -i root`

* Check disk usage by docker directory:

`sudo du -sh /var/lib/docker`

### Create a Docker Compose file for Jenkins

* Create a directory for jenkins
`mkdir jenkins`

* Enter the jenkins directory
`cd jenkins`

* Create a docker-compose file for jenkins on the host device using a text editor `vi docker-compose.yml`, save and exit `:wq`.

Use the docker-compose file found in the script folder of this project ![docker-compose](https://github.com/Kolawole-Ikeoluwa-Joshua/auto-m8/blob/main/scripts/docker-compose.yml) as reference.

### Start jenkins service

* Ensure that "jenkins_home" directory on host machine has proper permissions:
`sudo chown 1000:1000 jenkins_home -R`

* Start jenkins service:
`docker-compose up -d`

List running docker container `docker ps`, 

Access the Jenkins service by entering host machine `<ip-address>:8080` in your web browser

![unlock-jenkins](https://github.com/Kolawole-Ikeoluwa-Joshua/auto-m8/blob/main/docs/images/unlock%20jenkins.png)

Note: You are required to unlock jenkins with an admin password written to container logs, view logs of the jenkins container `docker logs -f jenkins` to access this password.

* Install Default Plugins, Create a user and finish Jenkins service setup

![jenkins-dashboard](https://github.com/Kolawole-Ikeoluwa-Joshua/auto-m8/blob/main/docs/images/jenkins%20dashboard.png)







