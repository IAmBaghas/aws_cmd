#!/bin/bash

sudo apt update -y
sudo curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

sudo mkdir /home/ubuntu/nodejsbasic
sudo chmod 755 /home/ubuntu/nodejsbasic

sudo git clone https://github.com/handipradana/nodejsbasic.git /home/ubuntu/nodejsbasic
cd /home/ubuntu/nodejsbasic
sudo npm install pm2 -g

sudo touch .env
sudo echo "DB_HOST=barang.czu6g62s67yq.us-west-2.rds.amazonaws.com" >> /home/ubuntu/nodejsbasic/.env
sudo echo "DB_USER=admin" >> /home/ubuntu/nodejsbasic/.env
sudo echo "DB_PASSWORD=adminpass" >> /home/ubuntu/nodejsbasic/.env
sudo echo "DB_DATABASE=barang" >> /home/ubuntu/nodejsbasic/.env
sudo echo "NODE_ENV=production" >> /home/ubuntu/nodejsbasic/.env

sudo npm install --prefix
sudo npm run start-prod
