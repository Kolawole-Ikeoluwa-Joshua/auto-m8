FROM jenkins/jenkins

USER root

RUN apt-get update && apt-get install -y python3-pip

RUN python3 -m pip install --upgrade ansible && \
    ansible --version 

USER jenkins