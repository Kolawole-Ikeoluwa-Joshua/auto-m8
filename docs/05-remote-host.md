# Create a CentOS Remote host using Docker

### Create SSH keys

Create a directory `centos7` on the host machine to store SSH keys. 

Use the command `ssh-keygen -f remote-key` to create SSH keys

output:
```
remote-key
remote-key.pub
```

Copy the private `remote-key` into the `jenkins_home/ansible` directory using command `cp centos7/remote-key jenkins_home/ansible/`

### Create Remote host Dockerfile

Create a [Dockerfile](/scripts/remote-host/Dockerfile) file, in the `centos7` directory.

Modify the [docker-compose](/scripts/docker-compose.yml) file to add the remote-host container.

Run `docker-compose build` to create images using Dockerfile.

Run `docker-compose up -D` to start services.



![remote-host](./images/remote%20host%20container.png)


### Verification

`cd centos7` directory on host machine, copy private remote-key to `/tmp` on jenkins-ansible container `docker cp remote-key jenkins:/tmp/remote-key`

Run `docker exec -ti jenkins bash` to access jenkins-ansible container.

Use SSH key to connect to the `remote_host` container. 

```
ssh -i remote-key remote_user@remote_host
```

![remote-access](./images/remote%20host%20access.png)




