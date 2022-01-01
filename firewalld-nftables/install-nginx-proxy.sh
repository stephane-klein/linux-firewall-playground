#!/usr/bin/env bash

set -ev

mkdir -p /srv/nginx-proxy/
cd /srv/nginx-proxy/

cat <<EOF > docker-compose.yml
version: '3.8'
services:
  nginx-proxy:
    image: jwilder/nginx-proxy:0.9.3
    restart: unless-stopped
    labels:
      com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy: ""
    network_mode: "host"
    volumes:
      - ./vhost.d/:/etc/nginx/vhost.d:rw
      - ./htpasswd:/etc/nginx/htpasswd:ro
      - ./certs/:/etc/nginx/certs:ro
      - /var/run/docker.sock:/tmp/docker.sock:ro
      - /usr/share/nginx/html
EOF

# Enable drop outgoing traffic
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 2 -j DROP

firewall-cmd --reload

docker compose up -d

# Enable drop outgoing traffic
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 2 -j DROP

firewall-cmd --reload
