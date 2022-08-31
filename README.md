# auto-m8
automating random tasks using jenkins as a central server

## Cluster Architecture
1  Jenkins Master VM:

## Prerequisites
### VM Hardware Requirements
2 GB of RAM 
40 GB Disk space
### Virtual Box
Download and Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) on windows host
### Vagrant
Vagrant provides an easier way to deploy multiple virtual machines on VirtualBox more consistenlty.
Download and Install [Vagrant](https://www.vagrantup.com/) on windows host

## Labs

## Labs 1:
### Provision Jenkins Instances

Note: You must have VirtualBox and Vagrant configured at this point

* First download the Centos 7 vagrant box from [Centos7Box](https://app.vagrantup.com/centos/boxes/7)
* Create a project folder, copy the downloaded centos7 vagrant box and put it in the directory you just created
* Add the centos7 box by typing the following command:
`vagrant box add CentOS-7-x86_64-Vagrant-2004_01.VirtualBox.box --name centos/7`

Replace centos/7 by the name you want the box to have and  centos-7.0-x86_64.box by the name of the box you downloaded.

* Create Vagrantfile
`vagrant init centos/7`

Edit the Vagrantfile and replace specifications to your needs

* Run Vagrant up to start up centos 7 VM
`vagrant up`

* Login to the CentOS 7 Virtual Machine with the command
`vagrant ssh`

## Labs 2:

### Install docker, docker-compose

* While logged into VM, Create a file with an editor of your choice and copy content from `scripts/install-docker.sh`, save and close editor
* Run this command on the script to set permissions:
`chmod +x install-docker.sh`

* Run the script with the command:
`sudo ./install-docker.sh`
 
* Log out and Login again, check Docker processes actively running with the command:
`docker ps`