#!/usr/bin/env bash

set -ev

mkdir -p /srv/miniflux/
cd /srv/miniflux/

cat <<EOF > docker-compose.yml
version: '3.8'
services:
  miniflux:
    image: miniflux/miniflux:2.0.34
    ports:
    - 8080:8080
    environment:
      VIRTUAL_PORT: 8080
      VIRTUAL_HOST: rss.example.com
      DATABASE_URL: postgres://miniflux:secret@postgres/miniflux?sslmode=disable
      RUN_MIGRATIONS: 1
      CREATE_ADMIN: 1
      ADMIN_USERNAME: johndoe
      ADMIN_PASSWORD: password
    depends_on:
      postgres:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "/usr/bin/miniflux", "-healthcheck", "auto"]

  postgres:
    image: postgres:14-alpine
    environment:
      POSTGRES_DB: miniflux
      POSTGRES_USER: miniflux
      POSTGRES_PASSWORD: secret
    volumes:
      - ./volumes/postgres/:/var/lib/postgresql/
    healthcheck:
      test: ['CMD', 'pg_isready']
      interval: 10s
      start_period: 30s
EOF

# Disable drop outgoing traffic for installation
firewall-cmd --permanent --direct --remove-rule ipv4 filter OUTPUT 2 -j DROP; firewall-cmd --reload

docker compose up -d miniflux --wait

# Enable drop outgoing traffic
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 2 -j DROP; firewall-cmd --reload
