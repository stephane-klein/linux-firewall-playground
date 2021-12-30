# iptables playground environment

## Prerequisites

On ArchLinux:

```sh
$ sudo pacman -S virtualbox vagrant virtualbox-host-modules-arch net-tools
```

Be careful, don't forget to install `net-tools` ([more info](https://wiki.archlinux.org/title/Vagrant#Virtual_machine_is_not_network_accessible_from_the_Arch_host_OS))

## Start VM
```sh
$ vagrant up
$ vagrant ssh
vagrant@ubuntu-focal:~$ sudo su
root@ubuntu-focal:/home/vagrant# cd /vagrant/
root@ubuntu-focal:/vagrant# ./install.sh
```

next, see [issues](https://github.com/stephane-klein/vagrant-iptables-playground/issues).
