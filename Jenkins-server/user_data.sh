#!/bin/bash

# Update packages
apt update -y

# Install Java (Required for Jenkins)
apt install fontconfig openjdk-21-jre -y

# Add Jenkins repo key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
apt update -y
apt install jenkins -y

# Enable and start Jenkins
systemctl enable jenkins
systemctl start jenkins
