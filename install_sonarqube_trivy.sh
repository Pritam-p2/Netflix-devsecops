#!/bin/bash

set -e

docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
echo "✅ SonarQube installed successfully"

sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
sudo apt-get install -y trivy

echo "✅ trivy installed successfully"
