#!/bin/bash

export IMAGE=$(sed -n '1p' /tmp/.auth)
export TAG=$(sed -n '2p' /tmp/.auth)
export PASS=$(sed -n '3p' /tmp/.auth)

# note: this docker authentication method has some security risks
docker login -u kolawolejoshua -p $PASS
cd ~/maven && docker-compose up -d