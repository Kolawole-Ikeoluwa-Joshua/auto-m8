FROM jenkins/jenkins

USER root

# Install Ansible
RUN apt-get update && apt-get install -y python3-pip

RUN python3 -m pip install --upgrade ansible && \
    ansible --version 

# Install Docker

RUN apt-get update && \
    apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Install Docker Compose

RUN curl -L https://github.com/docker/compose/releases/download/1.25.3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose

RUN usermod -aG docker jenkins
    
USER jenkins