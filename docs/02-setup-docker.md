# Install docker, docker-compose

* While logged into VM, Create a file with an editor of your choice and copy content from `scripts/install-docker.sh`, save and close editor

* Run this command on the script to set permissions:
`chmod +x install-docker.sh`

* Run the script with the command:
`sudo ./install-docker.sh`

* Add user to docker group
`sudo usermod -aG docker $USER`
 
* Log out and Login again, check Docker processes actively running with the command:
`docker ps`

Confirm Docker Compose installation:
`docker-compose --version`