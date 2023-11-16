#!/bin/bash

mv /etc/rc.local.orig /etc/rc.local

# Upgrade jessie
echo "."
echo "*** Updating and upgrading Debian Jessie. ***"
mv /etc/apt/sources.list /etc/apt/sources.list.bak
wget https://raw.githubusercontent.com/cassio-santos/Flash-CHIP-manjaro/master/CHIP-updater/jessie_source_list.txt
mv jessie_source_list.txt /etc/apt/sources.list

echo "."
echo "*** Installing debian keyring. ***"
apt update
apt install debian-keyring debian-archive-keyring -y --force-yes
sleep 5

echo "."
echo "*** apt update & upgrade ***"
apt update
apt upgrade -y --force-yes
sleep 5

sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo dpkg-reconfigure locales
sudo dpkg-reconfigure tzdata

sudo apt install git gcc make vim tmux libx11-dev libxtst-dev -y --force-yes
#git clone https://github.com/aleh/pocketchip-batt.git
#cd pocketchip-batt
#sudo make install
#cd
#git clone --bare https://git.nytpu.com/personal/dotfiles ~/.dotfiles
#alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#mkdir -p .config-backup && config checkout pocketchip 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
#config checkout pocketchip
#rm -r .config-backup/
#config config --local status.showUntrackedFiles no
#echo 'export SDL_GAMECONTROLLERCONFIG="030000001008000001e5000010010000,usb gamepad,platform:Linux,a:b2,b:b1,x:b3,y:b0,back:b8,start:b9,leftshoulder:b4,rightshoulder:b6,dpup:-a1,dpdown:+a1,dpleft:-a0,dpright:+a0,"' | sudo tee /etc/environment
#
#cd /tmp/
#wget www.lexaloffle.com/dl/chip/pico-8_0.2.2c_chip.zip
#sudo unzip -o pico-8_0.2.2c_chip.zip -d /usr/lib
## it breaks after the stretch upgrade so we need to add this library
#sudo wget -O /usr/lib/pico-8/libcurl.so.3 https://raw.githubusercontent.com/mackemint/PocketCHIP-buster-update/main/assets/libcurl.so.3
#
#cd
#git clone https://git.nytpu.com/forks/PocketDesk
#sudo ./PocketDesk/PocketDESK.sh


# Upgrade from jessie to stretch 
echo "."
echo "*** Upgrading Debian Jessie to Debian Stretch ***"
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak2
wget https://raw.githubusercontent.com/cassio-santos/Flash-CHIP-manjaro/master/CHIP-updater/stretch_source_list.txt
mv stretch_source_list.txt /etc/apt/sources.list

echo "."
echo "*** apt update & upgrade ***"
apt update
apt install linux-image-armmp -y --force-yes
apt full-upgrade -y --force-yes
sleep 5

# Define network variables
sudo chmod 666 /etc/NetworkManager/NetworkManager.conf
echo -e "[connection]" >> /etc/NetworkManager/NetworkManager.conf
echo -e "wifi.mac-address-randomization=1" >> /etc/NetworkManager/NetworkManager.conf
echo -e "" >> /etc/NetworkManager/NetworkManager.conf
echo -e "[device]" >> /etc/NetworkManager/NetworkManager.conf
echo -e "wifi.scan-rand-mac-address=no" >> /etc/NetworkManager/NetworkManager.conf

# Define X11 variables for stretch
sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf.bak
wget https://raw.githubusercontent.com/cassio-santos/Flash-CHIP-manjaro/master/CHIP-updater/stretch_x11.txt
mv stretch_x11.txt /etc/X11/xorg.conf

wget https://raw.githubusercontent.com/cassio-santos/Flash-CHIP-manjaro/master/CHIP-updater/stretch-to-buster.sh
chmod +x stretch-to-buster.sh
mv stretch-to-buster.sh /home/chip/
echo "."
echo "*** Update to Stretch finished. Reboot to continue the process. ***"