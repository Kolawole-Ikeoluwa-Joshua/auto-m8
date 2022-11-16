# CI/CD Pipeline to Deploy a Java Application

### Pull sample code from GitHub
Ensure you have git installed & configured on host machine.

```
sudo yum -y install git

git config --global user.name "Your Name"
git config --global user.email "youremail@domain.com"

git config --list
```
On host machine create a directory to store application code `java-app`.

In the `jenkins` directory, pull the java sample application `git clone https://github.com/jenkins-docs/simple-java-maven-app.git`.

Move the application code to `java-app` directory. `cp -r simple-java-maven-app/. java-app/`. cd into `java-app`,

Note: Make sure you delete the `.git` to avoid conflicts. `rm -rf .git`.

### Define Jenkinsfile for Java Application




