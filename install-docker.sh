#!/usr/bin/env bash

set -ev

# Disable drop outgoing traffic for installation
firewall-cmd --permanent --direct --remove-rule ipv4 filter OUTPUT 2 -j DROP
firewall-cmd --reload

# ** Install Ubuntu base packages
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -yq \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  python3-pip \
  python3-minimal


# ** Install Docker
# shellcheck disable=SC2024
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" > /etc/apt/sources.list.d/docker.list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-get update -y
apt-get install -y docker-ce
pip3 install docker-compose
usermod -aG docker vagrant

# Enable drop outgoing traffic
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 2 -j DROP

firewall-cmd --reload
