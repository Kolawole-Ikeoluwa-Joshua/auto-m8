#!/bin/bash

echo "************************************"
echo "******Pushing Image*****************"
echo "************************************"

IMAGE="maven-project"

echo "***Logging in to DockerHub***"
# ensure you use the right artifactory credentials
# note: this docker authentication method has some security risks
docker login -u kolawolejoshua -p $PASS
echo "****Tagging Image************"
docker tag $IMAGE:$BUILD_TAG kolawolejoshua/$IMAGE:$BUILD_TAG
echo "****Pushing Image************"
docker push kolawolejoshua/$IMAGE:$BUILD_TAG