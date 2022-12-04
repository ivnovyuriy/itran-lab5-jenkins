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