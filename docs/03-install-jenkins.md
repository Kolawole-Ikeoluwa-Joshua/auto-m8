# Setup Jenkins Service


### Install Jenkins

Download the official jenkins image from docker hub:

`docker pull jenkins/jenkins`

List docker images on host device:

`docker images`

Locate docker path on host device

`docker info | grep -i root`

Check disk usage by docker directory:

`sudo du -sh /var/lib/docker`