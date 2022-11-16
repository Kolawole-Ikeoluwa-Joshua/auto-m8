#!/bin/bash

echo maven-project > /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $PASS >> /tmp/.auth

# copy file to aws production server using ssh key
# ensure the private key file has the right user permissions
scp -i /opt/prod /tmp/.auth prod-user@44.201.197.10:/tmp/.auth
scp -i /opt/prod ./jenkins/deploy/publish.sh prod-user@44.201.197.10:/tmp/publish
# run remote command using ssh
ssh -i /opt/prod prod-user@44.201.197.10 "/tmp/publish"