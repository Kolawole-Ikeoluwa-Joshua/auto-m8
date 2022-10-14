# Create a simple ansible inventory

Copy private `remote-key` from `centos7` to the `jenkins-ansible` directory

Create an [ansible inventory](/scripts/jenkins-ansible/hosts) in the `jenkins-ansible` directory.

Copy the inventory `hosts` file into the jenkins container

```
cp hosts ../jenkins_home/ansible/
```

Run `docker exec -ti jenkins bash` to access jenkins-ansible container.

### Test Host connection using Ansible

Use ansible ping module to test connection to host in inventory.

```
ansible -i hosts -m ping test1
```
![ping-inventory](./images/ping%20server%20in%20ansible%20inventory.png)

