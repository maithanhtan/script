#!/bin/sh
#Install Package
apt update
apt-get upgrade -y
apt install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager docker-compose python3 adb libvirt-daemon-system libvirt-clients bridge-utils
if [[ "$(docker images -q tonymaithanh/emulator_nginx:latest 2> /dev/null)" != "" ]]; then
 echo "img pulled"
 exit 0
fi
sudo systemctl status libvirtd
sudo systemctl enable --now libvirtd
#Update Cert
wget https://raw.githubusercontent.com/maithanhtan/script/main/CorpIntermediate.cer
sudo cp CorpIntermediate.cer  /etc/ssl/certs
sudo update-ca-certificates --fresh
#AddtonyKey
sudo useradd -g 1000 -s /bin/bash -m tony
sudo adduser tony sudo
sudo sh -c "echo 'tony ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/tony"
sudo mkdir /home/tony/.ssh
sudo sh -c "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCVPFKkBJ++hqWRJa+ylq+rHb4lpooH2WijT7vrV3JF+H7ysFCMdNEOkCzWV9v8PcHasWeS5KPlY3rx5z7KBvTpDxYFxJBr/baP+6NWCNhEoI4941eaBVx1W2nPhdAJaYTibQ/TIpkwK2QsM2Lk1ugR9bwsfPnFzg7rxC0Y7VXI0Q== TonySSH' >> /home/tony/.ssh/authorized_keys"
#add adb
wget https://raw.githubusercontent.com/maithanhtan/script/main/adbkey
wget https://raw.githubusercontent.com/maithanhtan/script/main/adbkey.pub
mkdir /root/android
mv adbkey /root/android
mv adbkey.pub /root/android
#setup cron
sudo echo "@reboot sudo docker run -d tonymaithanh/playwrightclient:latest" >> mycron
sudo crontab mycron
sudo rm mycron
#start service
wget https://raw.githubusercontent.com/maithanhtan/script/main/docker-compose.yaml
docker-compose -f -d up
sudo init 6
