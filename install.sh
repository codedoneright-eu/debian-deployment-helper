#!/bin/bash
#Version: 1.7
#Additional information available in read.me file

clear

echo "Debian Deployment Helper for GNU/Linux Debian 12 (Bookworm)"
echo ""
echo "Before proceeding, make sure that your PC is connected to your router via"
echo "cable. DDH script assumes CABLE connection for the initial system setup."
echo "You can connect to WiFi after the reboot."
echo ""
echo "Script amends sources.list for network mirrors and adds non-free and"
echo "contrib repositories."
echo "Changelog and additional information available in read.me file"

echo ""
read -p "Press enter to continue or Ctrl+C to abort " foo

#Collect information from user
clear

echo "Please answer a few questions so that the script can tailor the experience"
echo "to your needs. To install utilities you have to install GUI as well."
echo ""
echo "Yes/No prompts should be answered with a lowercase y/n."

#Check username for uid=1000
USERNAME_INSTALL="$(cat /etc/passwd | grep 1000 | awk -F: '{print $1}')"

#Ask if the user wants to grant sudo to uid=1000
echo ""
read -p "Would you like to add your non-administrative user to sudo group (y/n): " SUDO_GIVE

	if [ $SUDO_GIVE = y ]; then
		usermod -aG sudo ${USERNAME_INSTALL}
		echo "User ${USERNAME_INSTALL} has been added to the sudo group"
	else
		echo ""
	fi

#Ask the user which GUI should be installed
echo ""
echo "Which desktop environment do you want to install..."
echo "GNOME - g"
echo "xfce4 - x"

echo ""
read -p "Which GUI woud you like to install (g/x)? " GUI_SELECT

#Ask if the user wants to install additional script files
echo ""
read -p "Would you like to install additional script files (y/n)? " SCRIPT_INSTALL

#Check if the user wants to add a network share
echo ""
read -p "Would you like to mount a network share (y/n)? " SHARE_INSTALL

	if [ $SHARE_INSTALL = y ]; then
		echo ""
		echo "Please provide..."
		read -p "Folder name for the share to be created in ~/ : " SHARE_FOLDER
		read -p "Network file share path: " SHARE_PATH
	else
		echo ""
	fi

#Ask if the user wants to add VPN
echo ""
read -p "Would you like to install VPN service? (y/n): " VPN_INSTALL

#Ask if the user wants to add spotify repository
echo ""
read -p "Would you like to add Spotify repository? (y/n): " SPOTIFY

#Ask if the user wants to add Signal repository
echo ""
read -p "Would you like to add Signal repository? (y/n): " SIGNAL

#Ask if the user wants to add other apps
echo ""
read -p "Would you like to download additional .deb files? (y/n): " OTHER_APPS

#Ask if the user wants to add nVidia drivers PPA
echo ""
read -p "Would you like to install nVidia drivers? (y/n): " NVIDIA_DRIVERS

#Ask if the user wants to add nVidia drivers PPA
echo ""
read -p "Would you like to install Brave browser? (y/n): " BRAVE

#Ask if the user wants to add nVidia drivers PPA
echo ""
read -p "Would you like to install GitHub desktop (Linux fork)? (y/n): " GITHUB

#Ask user if wants to reboot when finished
echo ""
read -p "Would you like to shutdown the system when finished? (y/n): " SHUTDOWN_NOW

#Display summary
clear

echo "Please check the summary below..."
echo ""
echo "Username:                          ${USERNAME_INSTALL}"
	if [ $SUDO_GIVE = y ]; then
		echo "                                   sudo granted"
	else
		echo "                                   sudo NOT granted"
	fi
echo "Desktop to be installed:           ${GUI_SELECT}"
echo "Additional script installation:    ${SCRIPT_INSTALL}"
echo "Network share added:               ${SHARE_INSTALL}"
	if [ $SHARE_INSTALL = y ]; then
		echo "NFS share folder to create:        ${SHARE_FOLDER}"
		echo "NFS share path:                    ${SHARE_PATH}"
	else
		echo "                                   no changes to fstab"
	fi
echo "Install VPN service:               ${VPN_INSTALL}"
echo "Install Spotify repository:        ${SPOTIFY}"
echo "Install Signal repository:         ${SIGNAL}"
echo "Download other apps:               ${OTHER_APPS}"
echo "Install nVidia drivers:            ${NVIDIA_DRIVERS}"
echo "Shutdown after finishing:          ${SHUTDOWN_NOW}"
echo ""
echo "Script will start working on your system after this prompt."
echo "Time needed for completion depends on your system and internet speed"
echo ""
echo "Log file will be created in /home/${USERNAME_INSTALL}/ddh-log.txt"
echo ""
read -p "Press enter to continue or Ctrl+C to abort " foo

#Script starts actual work here
clear

#Create log
touch /home/${USERNAME_INSTALL}/ddh-log.txt
chown ${USERNAME_INSTALL}:${USERNAME_INSTALL} /home/${USERNAME_INSTALL}/ddh-log.txt

DDH_LOG=/home/${USERNAME_INSTALL}/ddh-log.txt

echo "Debian Deployment Helper log
============================
" >> ${DDH_LOG}

#Add note in log if user granted sudo
if [ $SUDO_GIVE = y ]; then
	echo "User ${USERNAME_INSTALL} has been granted sudo privilege" >> ${DDH_LOG}
else
	echo "User ${USERNAME_INSTALL} has not been granted sudo privilege" >> ${DDH_LOG}
fi

#Export variables for use with other modules
export USERNAME_INSTALL
export SUDO_GIVE
export GUI_SELECT
export SCRIPT_INSTALL
export SHARE_INSTALL
export SHARE_FOLDER
export SHARE_PATH
export VPN_INSTALL
export SPOTIFY
export SIGNAL
export OTHER_APPS
export BRAVE
export GITHUB
export NVIDIA_DRIVERS
export DDH_LOG

#Amend sources.list, sources contain contrib and non-free mirrors
echo "
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main  contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main  contrib non-free non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware" > /etc/apt/sources.list

#Connect to the internet by establishing connection
echo "Establishing connection and updating the system..."
dhclient
apt update
apt upgrade -y

echo "System is up to date" >> ${DDH_LOG}

#Install GUI + utilities
./data/02_packages_system.sh
./data/03_packages_GUI.sh
./data/04_packages_utilities.sh

#Install additional script files and create aliases for them
./data/05_add_script.sh

#Amend fstab for network share
./data/06_shares.sh

#Add aliases
./data/07_alias.sh

#Add vpn
./data/08_vpn.sh

#Add spotify repository
./data/09_spotify.sh

#Install other non-free apps
./data/10_other_apps.sh

#Install nVidia drivers
./data/11_nvidia.sh

#Add spotify repository
./data/12_signal.sh

#Add brave repository
./data/13_brave.sh

#Add github repository
./data/14_github.sh

#Put wallpaper in the correct place for immediate use
#./data/13_wallpaper.sh

#Write out all installed packages (moved here so the long list is at the end)
echo "
Following packages have been installed:" >> ${DDH_LOG}
awk '$3~/^install$/ {print $4;}' /var/log/dpkg.log >> ${DDH_LOG}

#Write out all installed packages (moved here so the long list is at the end)
echo "
Commands to install additional software:

sudo apt install spotify-client -y
sudo apt install signal-desktop -y
sudo apt install brave-browser -y
sudo dpkg -i XnViewMP-linux-x64.deb -y
sudo dpkg -i steam_latest.deb -y

" >> ${DDH_LOG}

apt update

#Shutdown section
	if [ $SHUTDOWN_NOW = y ]; then
		shutdown now
	else
		echo ""
		echo "Script has finished, please reboot your system..."
	fi

echo ""

