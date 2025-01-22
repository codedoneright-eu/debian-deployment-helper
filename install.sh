#!/bin/bash
#Version: 1.9
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
echo "Caution! Any changes to your system will be made AFTER the summary"
echo "with all your choices, you can safely cancel the execution of this" 
echo "script before that by hitting CTRL+C."
echo ""
echo "Caution! XFCE packages have NOT been looked at after release of"
echo "Debian 12, please use with caution. Will amend once I reinstall"
echo "Debian on my laptop."
echo ""
read -p "Press enter to continue or Ctrl+C to abort " foo

#Collect information from user
clear

echo "Please answer a few questions so that the script can tailor the experience"
echo "to your needs. To install utilities you have to install GUI as well. In case"
echo "you select anything else than Gnome or XFCE, the script defaults to Gnome"
echo ""
echo "Yes/No prompts should be answered with a lowercase y/n."

#Check username for uid=1000
USERNAME_INSTALL="$(cat /etc/passwd | grep 1000 | awk -F: '{print $1}')"

#Ask if the user wants to grant sudo to uid=1000
echo ""
read -p "Would you like to add your non-administrative user to sudo group (y/n): " SUDO_GIVE


#Ask the user which GUI should be installed
echo ""
echo "Which desktop environment do you want to install..."
echo "GNOME - g"

echo ""
read -p "Which GUI woud you like to install (g)? " GUI_SELECT

echo ""
read -p "Would you like to install additional script files (y/n)? " SCRIPT_INSTALL

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

echo ""
read -p "Would you like to install VPN service? (y/n): " VPN_INSTALL

echo ""
read -p "Would you like to install nVidia drivers? (y/n): " NVIDIA_DRIVERS

echo ""
read -p "Would you like to add Spotify repository? (y/n): " SPOTIFY

#echo ""
#read -p "Would you like to add Signal repository? (y/n): " SIGNAL

echo ""
read -p "Would you like to add Brave browser repository? (y/n): " BRAVE

echo ""
read -p "Would you like to add GitHub desktop repository? (y/n): " GITHUB

echo ""
read -p "Would you like to add Mullvad VPN repository? (y/n): " MULLVAD

echo ""
read -p "Would you like to download additional .deb files? (y/n): " OTHER_APPS

echo ""
read -p "Would you like to rbeoot the system when finished? (y/n): " SHUTDOWN_NOW

#Display summary
clear

echo "Please check the summary below..."
echo ""
echo "Username:                          ${USERNAME_INSTALL}"
	if [ $SUDO_GIVE = y ]; then
		echo "                                   sudo WILL be granted"
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
echo "Install nVidia drivers:            ${NVIDIA_DRIVERS}"
echo "Install Spotify repository:        ${SPOTIFY}"
echo "Install Signal repository:         ${SIGNAL}"
echo "Install Brave repository:          ${BRAVE}"
echo "Install GitHub repository:         ${GITHUB}"
echo "Install Mullvad repository:        ${MULLVAD}"
echo "Download other apps:               ${OTHER_APPS}"
echo "Shutdown after finishing:          ${SHUTDOWN_NOW}"
echo ""
echo "So far no changes to your system have been made."
echo ""
echo "Script will start working on your system after this prompt."
echo "Time needed for completion depends on your system and internet speed"
echo ""
echo "If you chose to install nVidia drivers then you will be asked to hit"
echo "return at some point during the installation"
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

#Grant sudo
if [ $SUDO_GIVE = y ]; then
	usermod -aG sudo ${USERNAME_INSTALL}
	echo "User ${USERNAME_INSTALL} has been added to the sudo group" >> ${DDH_LOG}
elif
	[ $SUDO_GIVE = n ]; then
	echo "User ${USERNAME_INSTALL} NOT added to the sudo group" >> ${DDH_LOG}
else
	echo "Caution! Wrong selection to sudo granting question" >> ${DDH_LOG}
	echo "In order to grant sudo to the default user please run:" >> ${DDH_LOG}
	echo "whoami" >> ${DDH_LOG}
	echo "This is your username needed 3 lines later" >> ${DDH_LOG}
	echo "sudo su -" >> ${DDH_LOG}
	echo "Provide root password" >> ${DDH_LOG}
	echo "usermod -aG sudo $name-of-your-user" >> ${DDH_LOG}
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
export MULLVAD
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
echo "Updating the system..."
#dhclient
apt update
apt upgrade -y

echo "System is up to date" >> ${DDH_LOG}

#Execute modules
./data/02_packages_system.sh
./data/03_packages_GUI.sh
./data/04_packages_utilities.sh
./data/05_add_script.sh
./data/06_shares.sh
./data/07_alias.sh
./data/08_vpn.sh
./data/09_spotify.sh
./data/10_other_apps.sh
./data/11_nvidia.sh
#./data/12_signal.sh
./data/13_brave.sh
./data/14_github.sh
./data/15_mullvad.sh

echo "
Commands to install additional software:

sudo apt install spotify-client -y
sudo apt install signal-desktop -y
sudo apt install brave-browser -y
sudo apt install mullvad-vpn -y
sudo apt install github-desktop -y
XnViewMP-linux-x64.deb - install via Software Install
steam_latest.deb - install via Software Install

" >> ${DDH_LOG}

apt update

#Shutdown section
	if [ $SHUTDOWN_NOW = y ]; then
		reboot now
	else
		echo ""
		echo "Script has finished, please reboot your system..."
	fi

echo ""

