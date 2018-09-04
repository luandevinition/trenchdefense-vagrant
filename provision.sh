#!/bin/bash

echo "**************************START INSTALLING APPLICATIONS**************************"

#Add repository for php-fpm
sudo apt-get install software-properties-common build-essential  -y
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

#Install Nginx
sudo apt-get install nginx -y
sudo systemctl stop nginx.service
sudo systemctl start nginx.service
sudo systemctl enable nginx.service

#Install PHP-FPM + extensions
sudo apt-get install -y php7.1-fpm php7.1-cli php7.1-common php7.1-mbstring php7.1-curl php7.1-gd php7.1-intl php7.1-xml php7.1-xsl php7.1-xmlrpc php7.1-mysql php7.1-mcrypt php7.1-zip php-solr php-memcache php-redis php7.1-sqlite3

#Instal composer
cd ~/
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

#Install MySQL
echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
sudo apt-get -y install mysql-server

#Install Protoc
cd /vagrant/protoc_config
tar -zxf protobuf-2.6.0.tar.gz
cd /vagrant/protoc_config/protobuf-2.6.0
./configure
make
make check
sudo make install
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
sudo ldconfig
protoc --version


echo "Copy php.ini"
sudo cp /vagrant/php_config/php.ini /etc/php/7.1/fpm/php.ini
echo "Restart PHP-FPM"
sudo service php7.1-fpm restart
echo "Copy sample nginx virtualhost"
sudo cp /vagrant/nginx_config/sample /etc/nginx/sites-enabled/sample
echo "Copy sample index.php"
sudo cp -R /vagrant/sample /var/www/
echo "Copy mysql config"
sudo cp /vagrant/mysql_config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

echo "Copy nginx virtualhost"
sudo cp /vagrant/nginx_config/trenchdefense /etc/nginx/sites-enabled/trenchdefense
echo "Restart nginx"
sudo service nginx restart

mysql -u root -proot -e "DROP DATABASE IF EXISTS trenchdefense;"
mysql -u root -proot -e "CREATE DATABASE trenchdefense CHARACTER SET utf8;"
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON trenchdefense.* TO 'trenchdefense'@'localhost' IDENTIFIED BY 'trenchdefense';"
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON trenchdefense.* TO 'trenchdefense'@'%' IDENTIFIED BY 'trenchdefense';"
echo "**************************END INSTALLING APPLICATIONS**************************"
