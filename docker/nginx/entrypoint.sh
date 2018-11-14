#!/bin/bash
set -e

cd /etc/nginx/certs/
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj "/C=FR/ST=IDF/L=Paris/O=Baguette Corp/OU=Org/CN=docker.localhost" -nodes
cat key.pem cert.pem > docker.localhost.pem

/usr/sbin/nginx -c /etc/nginx/nginx.conf -g "daemon off;"
