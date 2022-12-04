# configure nginx
cp /tmp/nginx.conf /etc/nginx/nginx.conf
cp /tmp/nginx-wp /etc/nginx/sites-available/nginx-wp

mkdir -p /var/cache/nginx && sudo chown -R www-data:www-data /var/cache/nginx

sudo rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/nginx-wp /etc/nginx/sites-enabled/nginx-wp

# configure mysql
mysql < /tmp/db.sql
rm /tmp/db.sql

# configure wordpress
touch /var/www/html/.htaccess
mkdir /var/www/html/wp-content/upgrade
cp /tmp/wp-config.php /var/www/html/wp-config.php

sudo chown -R www-data:www-data /var/www/html/  
sudo chmod -R 755 /var/www/html/ 

# restart service nginx
sudo systemctl restart nginx 

# restart service php-fpm
sudo systemctl restart php7.4-fpm