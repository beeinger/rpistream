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
apt-get install --assume-yes --no-install-recommends nodejs chromium-browser ntfs-3g lsof

npm install serve -g

mkdir /home/pi/app

echo "UUID=706944a6-7d0f-4a45-9f8c-7fb07375e9f7 /mnt/drive FSTYPE defaults,auto,users,rw,nofail,umask=000 0 0" >> /etc/fstab

echo "nohup serve /mnt/drive -l 3000 </dev/null >/dev/null 2>&1 &" >> /home/pi/.bash_profile
echo "nohup npm start --prefix /home/pi/app </dev/null >/dev/null 2>&1 &" >> /home/pi/.bash_profile

while read -n1 -r -p "Reboot? [y]es|[n]o: "; do
  echo
  case $REPLY in
    y) echo "Rebooting..." && sudo reboot;;
    n) echo "Finished" && echo && break;;
    *) echo && echo "What XD?" && echo;;
  esac
done