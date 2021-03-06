#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../"

export DEBIAN_FRONTEND=noninteractive
apt update -y
apt upgrade -y
apt install -y \
    firewalld

# Replace iptables FireWallbackend by nftables
sed -i "s/FirewallBackend=iptables/FirewallBackend=nftables/g" /etc/firewalld/firewalld.conf

systemctl enable firewalld
systemctl start firewalld

firewall-cmd --permanent --zone=public --add-interface=enp0s8
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
./drop-outgoing-traffic.sh
