#!/bin/bash

sudo apt-get install nano software-properties-common python3-software-properties -y
sudo apt-get update -y
sudo apt install apache2 mysql-client mysql-server php libapache2-mod-php -y
sudo apt install graphviz aspell ghostscript clamav php8.1-pspell php8.1-curl php8.1-gd php8.1-intl php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-ldap php8.1-zip php8.1-soap php8.1-mbstring -y
sudo service apache2 start
sudo systemctl enable apache2
