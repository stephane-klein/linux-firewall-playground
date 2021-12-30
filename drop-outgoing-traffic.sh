#!/usr/bin/env bash

set -ev

# This configuration come from https://serverfault.com/a/643145/39405
#

# Allow established connections
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 0 -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow for DNS queries

firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 1 -p tcp -m tcp --dport 53 -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 1 -p udp --dport 53 -j ACCEPT

# Allow specific address (51.158.146.33 is stephane-klein.info)
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 1 -d 51.158.146.33 -j ACCEPT

# Deny everything else
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 2 -j DROP

firewall-cmd --reload
