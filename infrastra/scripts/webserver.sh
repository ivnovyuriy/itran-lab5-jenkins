#!/bin/bash

# update && upgrade
sudo apt-get -y update && sudo apt-get -y upgrade 
sudo apt-get -y install wget 
sudo apt install net-tools

# installing nginx
sudo apt-get -y install nginx

# make sure nginx is started
sudo systemctl enable nginx
sudo service nginx start

# installing MySQL
sudo apt-get -y install mysql-server mysql-client

# make sure mysql is started
sudo systemctl enable mysql

# installing PHP
sudo apt install -y php7.4-fpm
sudo apt install -y php7.4-cli
sudo apt install -y php7.4-common 
sudo apt install -y php7.4-mysql
sudo apt install -y php7.4-zip
sudo apt install -y php7.4-gd
sudo apt install -y php7.4-mbstring
sudo apt install -y php7.4-curl
sudo apt install -y php7.4-xml
sudo apt install -y php7.4-bcmath

# Installing Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-cache policy docker-ce
sudo apt install -y docker-ce
sudo usermod -a -G docker ubuntu

# installing WordPress:latest

rm /var/www/html/index.*  
wget -c http://wordpress.org/latest.tar.gz  
tar -xzvf latest.tar.gz  
rsync -av wordpress/* /var/www/html/ 
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
echo "wp-config.php is copied"
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "|                       Complete!                                   |"

# Adding cron job that find && delete old big files on /tmp ditectory
echo "0 0 * * * /usr/bin/find /tmp  -type f -ctime +14  -size +5M -exec rm -rf {} \;" >> /etc/crontab

# run another bash script to configure WP && Nginx && MySQL
sudo bash /tmp/wpconfig.sh