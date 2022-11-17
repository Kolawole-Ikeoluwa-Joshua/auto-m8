#!/bin/bash

echo maven-project > /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $PASS >> /tmp/.auth

# copy file to aws production server using ssh key
# ensure the private key file has the right user permissions
scp -i /opt/prod /tmp/.auth prod-user@<aws_public_ip_address>:/tmp/.auth
scp -i /opt/prod ./jenkins/deploy/publish.sh prod-user@<aws_public_ip_address>:/tmp/publish
# run remote command using ssh
# ensure prod-user has the right access to run script
ssh -i /opt/prod prod-user@<aws_public_ip_address> ". /tmp/publish"
