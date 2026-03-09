#!/bin/bash

# Update packages
apt update -y

# Install docker
apt install -y docker.io
usermod -a -G docker ubuntu
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
