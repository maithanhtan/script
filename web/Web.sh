#!/bin/sh
set -e
sudo apt update && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
sudo apt install docker-ce docker-compose wget -y
cd /root
wget -o /root/appsettings.json https://raw.githubusercontent.com/maithanhtan/script/main/web/appsettings.json
wget -o /root/docker-compose.yml https://raw.githubusercontent.com/maithanhtan/script/main/web/docker-compose.yml
HOSTNAME=$HOSTNAME docker-compose up -d
