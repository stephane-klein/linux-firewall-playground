# Linux firewall playground environment

This playground use [`firewalld`](https://firewalld.org/) software which is a `nftables` overlay.

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

## firewalld configuration

See [`./drop-outgoing-traffic.sh`](./drop-outgoing-traffic.sh) file.

## A few experiments

All outgoing traffic are dropped:

```sh
root@ubuntu-focal:/vagrant# curl --connect-timeout 1 https://linuxfr.org
curl: (28) Connection timed out after 1001 milliseconds
```

An exception is configured for `stephane-klein.info` domain:

```sh
root@ubuntu-focal:/vagrant# curl -s -o /dev/null -w "%{http_code}"  https://stephane-klein.info
```
