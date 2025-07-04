#!/bin/bash
sudo yum update
#install mysql client and apache server
sudo yum install -y mysql
sudo yum install -y httpd
sudo service hrrpd start
#application dependencies you need for WordPress
sudo amazon-linux-extras install -y php8.2
#download and extract wordpress
wget https://wprdpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo cp -r wprdpress/* /var/www/html/
cp /var/www/html/wp-config-sample-php /var/www/html/wp-config.php
# make wordpress run under apache user
chown -R apache:apache /var/www/html/
rm -rf wordpress latest.tar.gz
