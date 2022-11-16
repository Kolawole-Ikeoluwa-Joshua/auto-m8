# CI/CD Pipeline to Deploy a Java Application

### Pull sample code from GitHub
Ensure you have git installed & configured on host machine.

```
sudo yum -y install git

git config --global user.name "Your Name"
git config --global user.email "youremail@domain.com"

git config --list
```
On host machine create a directory to store application code `pipeline/java-app`.

In the `pipeline` directory, pull the java sample application `git clone https://github.com/jenkins-docs/simple-java-maven-app.git`.

Move the application code to `java-app` directory. `cp -r simple-java-maven-app/. java-app/`. cd into `java-app`,

Note: Make sure you delete the `.git` to avoid conflicts. `rm -rf .git`.

### Define Jenkinsfile for Java Application

In the `pipeline` directory create the [Jenkinsfile](/scripts/pipeline/Jenkinsfile).


### Build a JAR file for Application using Docker

In the `pipeline` directory, create a directory `jenkins/build`. This new directory will store a [script](/scripts/pipeline/build/mvn.sh), which will setup a maven container with mounted volumes to our `java-app` and `dependency files` for creating JAR file.

#### Test JAR build script

Use the following steps:
```
cd jenkins/build

vi mvn.sh      #copy content from /scripts/pipeline/build/mvn.sh and save file

chmod +x mvn.sh

cd pipline 

./jenkins/build/mvn.sh mvn -B -DskipTests clean package    #run the mvn script to build JAR

ls java-app/target/      # to view my-app-1.0-SNAPSHOT.jar JAR file 
```
Note: While testing your build script, If you get the following error message `Detected Maven Version: 3.5.0 is not in the allowed range [3.5.4,).` Simple change the `requireMavenVersion` in your pom.xml file and restart build.


### Dockerize your Java Application

navigate into the `jenkins/build` directory and create [Dockerfile](/scripts/pipeline/build/Dockerfile) & [docker-compose](/scripts/pipeline/build/docker-compose.yml) files to dockerize your Java application.

Note: Set the `$BUILD_TAG` env variable to any random number, to test our docker-compose file.


#### Create a script to automate building our application image

Create this [script](/scripts/pipeline/build/build.sh) on host machine to automate building our application image.

Use the following steps on host machine:

```
cd jenkins/build

vi build.sh                 #copy content from the script above and save file

chmod +x build.sh

cd pipline 

./jenkins/build/build.sh     #run the script to build application image

docker images                # to view new docker image

```

### Configure the Jenkinsfile build step

To configure the build step in our CICD process add the automation scripts and commands to run them in the right order to the build section of the [Jenkinsfile](/scripts/pipeline/Jenkinsfile).


### Test Java Application using Maven & Docker

Create a [script](/scripts/pipeline/test/mvn.sh) to automate the test process. Use the following steps:

```
mkdir jenkins/test

cd jenkins/test

vi mvn.sh  #use the content in the script above and save file

chmod +x mvn.sh

```
### Configure the Jenkinsfile test step

To configure the test step in our CICD process add the automation scripts and mvn test commands in the right order to the test section of the [Jenkinsfile](/scripts/pipeline/Jenkinsfile).


### Create a Remote Machine as the Production/Deployment Environment

For this section, create a ubuntu linux server on AWS, Also ensure the server has the following configs:

* SSH access
* A `prod-user` with SSH key connection
* Docker
* docker-compose

![aws-prod-server](./images/aws%20prod%20server.png)

### Set up DockerHub Private Repository

Log onto dockerhub and create a private repository `maven-project` to store artifacts from pipeline.

### Automate push process for CICD pipeline

Create a [script](/scripts/pipeline/push/push.sh) to automate the push process for the pipeline. Use the following steps:

```
cd jenkins/push

vi push.sh    #use content of the above script and save file.

chmod +x push.sh
```
Note: Set the `$BUILD_TAG` env variable to any random number, `$PASS` env variable to artifactory password, to test `push.sh` script

### Configure the Jenkinsfile push step

To configure the test step in our CICD process add the automation scripts and push commands to the push section of the [Jenkinsfile](/scripts/pipeline/Jenkinsfile).

### Automate the deployment stage for the CICD pipeline
Create scripts to automate the deployment to the production server using docker-compose utilities.

- [Deployment script](/scripts/pipeline/deploy/deploy.sh)

- [Publish script](/scripts/pipeline/deploy/publish.sh)

- [docker-compose](/scripts/pipeline/deploy/docker-compose.yml) for aws prod
Use the following steps:

* on host machine:
```
mkdir jenkins/deploy

vi deploy.sh      #use the cotents from the deployment script above and save file.

vi publish.sh     #use the cotents from the publish script above and save file.

chmod +x deploy.sh

chmod +x publish.sh

```
* on remote machine (aws ubuntu prod server):

```
mkdir maven             # in the prod-user home directory

cd maven

vi docker-compose.yml   # use the content in the docker-compose file above
```

### Configure the Jenkinsfile Deploy step

To configure the deploy step in our CICD process add the automation scripts and deployment commands in the right order to the deploy section of the [Jenkinsfile](/scripts/pipeline/Jenkinsfile).
