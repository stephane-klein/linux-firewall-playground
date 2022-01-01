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

Now let's test the compatibility of `firewalld` with Docker.

Let's start by installing Docker environment:

```sh
root@ubuntu-focal:/vagrant# ./install-docker.sh
```

Install [`nginx-proxy`](https://github.com/nginx-proxy/nginx-proxy):

```sh
root@ubuntu-focal:/vagrant# ./install-nginx-proxy.sh
```

Install [`miniflux`](https://miniflux.app/):

```sh
root@ubuntu-focal:/vagrant# ./install-miniflux.sh
```

but here, I have this error that I must correct (issue https://github.com/stephane-klein/linux-firewall-playground/issues/14):

```
 ⠿ Network miniflux_default  Error                                                                                                                      0.0s
failed to create network miniflux_default: Error response from daemon: Failed to Setup IP tables: Unable to enable SKIP DNAT rule:  (iptables failed: iptable
s --wait -t nat -I DOCKER -i br-ffa021fb77f6 -j RETURN: iptables: No chain/target/match by that name.
 (exit status 1))
```

Next, see [issues](https://github.com/stephane-klein/linux-firewall-playground/issues).
