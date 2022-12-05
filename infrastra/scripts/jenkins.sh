#!/bin/bash

# Get public IP Jenkins server
public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")

# update && upgrade
sudo apt-get -y update && sudo apt-get -y upgrade 
sudo apt-get -y install wget 
sudo apt install -y net-tools

# Setting Up a Basic Firewall
sudo ufw allow OpenSSH
sudo ufw allow 8080/tcp

sudo ufw --force enable
sudo ufw status

# Installing Git
sudo apt-get install -y git

# Installing Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-cache policy docker-ce
sudo apt install -y docker-ce
sudo systemctl status docker

# Installing Java 11 JDK
sudo apt install -y openjdk-11-jdk

# Installing Jenkins
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install -y jenkins

# Starting Jenkins
sudo systemctl start jenkins
# sudo systemctl status jenkins

echo " 
################################################
#             Congratulations!                 #
################################################

Your Jenkins server is running.
   1. API: http://$public_ip:8080

echo "