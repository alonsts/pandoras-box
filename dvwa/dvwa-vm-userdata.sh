#!/bin/bash
## dvwa userdata to install app on new ubuntu linux vm
## from https://securingninja.com/how-to-install-dvwa-in-ubuntu/
apt update && sudo apt upgrade -y 
apt -y install apache2 mariadb-server php php-mysqli php-gd libapache2-mod-php
mysql_secure_installation --use-defaults #(NEED TO PASS ALL N to parameters to run silently)
mysql -u root -h localhost #login to mariadb in monitor mode
CREATE DATABASE dvwa;
CREATE USER 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';
GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';
exit
#copy dvwa and set ownership of www directory
cd /var/www/html
rm /var/www/html/*
#rm everything in html
sudo git clone https://github.com/digininja/DVWA.git .
sudo chown -R www-data:www-data /var/www/html/*
cp /var/www/html/config/config.inc.php.dist /var/www/html/config/config.inc.php
php setup.php