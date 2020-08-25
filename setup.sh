#!/bin/bash

# Ensure run with root privilinges
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

# Enable autologin to CLI
raspi-config nonint do_boot_behaviour B2

# Install dependencies
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
apt-get update
apt-get upgrade --assume-yes
apt-get install --assume-yes --no-install-recommends nodejs

npm install --prefix /home/pi/app
mkdir /home/pi/app/public

echo "nohup npm start --prefix /home/pi/app </dev/null >/dev/null 2>&1 &" >> /home/pi/.bash_profile

while read -n1 -r -p "Reboot? [y]es|[n]o: "; do
  echo
  case $REPLY in
    y) echo "Rebooting..." && sudo reboot;;
    n) echo "Finished" && echo && break;;
    *) echo && echo "What XD?" && echo;;
  esac
done
