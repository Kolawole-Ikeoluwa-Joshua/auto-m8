#!/bin/bash

echo "************************************"
echo "******Testing your Application******"
echo "************************************"


# maven container with mounted volumes to our `java-app` and `dependency files` for testing application code.
docker run --rm -v $PWD/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine "$@"