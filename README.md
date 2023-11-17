# Revive an outdated C.H.I.P. from factory OS to Debian Buster
This guide and scripts are based on the excelent work made by https://github.com/Thore-Krug/Flash-CHIP and the guide in https://gist.github.com/luzhuomi/526fbcc30f3522f09eacf20d0f776fa5

## Instructions
### Part 1: Stock image
1. Remove the C.H.I.P. from its case (in case you have a Pocket C.H.I.P.).
2. Connect the FEL and a GROUND pin of the C.H.I.P. (for example, with a paperclip).
3. Connect the C.H.I.P. its micro USB port to a USB port of your Linux machine. Make sure that the port and cable allow for plenty of power. If you get a FEL error, it may be because the C.H.I.P. is running under-voltage.
4. On the Linux machine:
    - run ` git clone https://github.com/cassio-santos/Flash-CHIP-manjaro.git` to clone this repository
    - `cd` into the location where you stored this repository
    - run `sudo chmod +x Flash.sh`
    - run `./Flash.sh`
    - Select the version you want to install
    - Wait until the installation finishes
    
### Part 2: Get jessie to connect to the network
1. Remove the FEL connection (the paperclip)
2. Unplug 3 seconds
3. Plug the C.H.I.P. again
4. Connect to the chip using `sudo screen /dev/ttyACM0`
5. Use user: chip  and password: chip to connect
6. run `sudo nmtui` to set-up a wifi connection to YOUR_SSID
7. run `sudo nmcli c` to show your current connections
8. run `sudo nmcli c m <YOUR SSID> connection.autoconnect yes` to set autoconnection to YOUR_SSID wifi in case of trouble
9. use `ip addr | grep "inet " | awk 'NR==2{print $2}' | cut -d/ -f1 ` to get your CHIP_IP. From your linux computer open other terminal and connect using `ssh chip@CHIP_IP`. You can close the terminal running `screen`.
    
### Part 3: upgrade debian jessie to debian stretch
1. run `sudo su -` to allow all the next changes as superuser
2. run `bash <(curl -s https://raw.githubusercontent.com/cassio-santos/Flash-CHIP-manjaro/master/CHIP-updater/jessie-to-stretch.sh)` to update from Debian Jessie to Debian Stretch
3. reboot C.H.I.P. into Debian Stretch
                    
### Part 4: upgrade debian stretch to debian buster
1. From your linux computer open other terminal and connect using `ssh chip@<CHIP IP>`.
1. run `sudo su -` to allow all the next changes as superuser
2. run `bash <(curl -s https://raw.githubusercontent.com/cassio-santos/Flash-CHIP-manjaro/master/CHIP-updater/stretch-to-buster.sh)` to update from Debian Stretch to Debian Buster
3. reboot C.H.I.P. into Debian Buster
