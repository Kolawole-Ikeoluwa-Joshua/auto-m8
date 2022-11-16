#!/bin/bash

# Copy the new JAR to the build location
cp -f java-app/target/*.jar jenkins/build/

echo "**************************************"
echo "******Building Application Image******"
echo "**************************************"

cd jenkins/build/ && docker-compose -f docker-compose.yml build --no-cache