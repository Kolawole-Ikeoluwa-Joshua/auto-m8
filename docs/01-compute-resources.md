# Provision Jenkins Instances

Note: You must have VirtualBox and Vagrant configured at this point


CD into vagrant directory

`cd auto-m8\vagrant`

Run Vagrant up

`vagrant up`

This does the below:

- Deploys 1 VM - with the name 'jenkins'

- Set's IP addresses in the range 192.168.5.31

    | VM            |  VM Name               | Purpose        | IP           | Forwarded Port   |
    | ------------  | ---------------------- |:--------------:| ------------:| ----------------:|
    | jenkins       | jenkins                | Jenkins Server | 192.168.5.31 |     2740         |


    > These are the default settings. These can be changed in the Vagrant file

- Add's a DNS entry to each of the nodes to access internet
    > DNS: 8.8.8.8


### SSH to the nodes

  From the directory you ran the `vagrant up` command, run `vagrant ssh <vm>` for example `vagrant ssh jenkins`.
  > Note: Use VM field from the above table and not the vm name itself.

