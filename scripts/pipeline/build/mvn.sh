#!/bin/bash

echo "**********************************"
echo "******Building your JAR file******"
echo "**********************************"

WORKSPACE=/home/jenkins/jenkins/jenkins_home/workspace/pipeline-docker-maven

# maven container with mounted volumes to our `java-app` and `dependency files` for creating JAR file.
docker run --rm -v $WORKSPACE/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine "$@"