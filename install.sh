#!/bin/bash
#Version: 1.4
#Additional information available in read.me file

clear

echo "Debian Deployment Helper for GNU/Linux Debian 11 (Buster)"
echo ""
echo "Before proceeding, make sure that your PC is connected to your router via"
echo "cable. DDH script assumes cable connection for the initial system setup."
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
echo "Yes/No prompts should be answered with lowercase y/n."

#Check username for uid=1000
USERNAME_INSTALL="$(cat /etc/passwd | grep 1000 | awk -F: '{print $1}')"

#Ask if the user wants to grant sudo to uid=1000
echo ""
read -p "Would you like to add your non-administrative user to sudo group (y/n): " SUDO_GIVE

	if [ $SUDO_GIVE = y ]; then
		usermod -aG sudo ${USERNAME_INSTALL}
		echo ""
		echo "User ${USERNAME_INSTALL} has been added to the sudo group"
	else
		echo ""
	fi

#Ask the user which GUI should be installed
echo ""
echo "Please choose desktop environment..."
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

#Ask user if wants to reboot when finished
echo ""
read -p "Would you like to shutdown the system when finished? (y/n): " SHUTDOWN_NOW

#Export variables for use with other modules
export USERNAME_INSTALL
export SUDO_GIVE
export GUI_SELECT
export SCRIPT_INSTALL
export SHARE_INSTALL
export SHARE_FOLDER
export SHARE_PATH
export VPN_INSTALL

#Display summary
clear

echo "Please check the summary below..."
echo ""
echo "Username:                          ${USERNAME_INSTALL}"
	if [ $SUDO_GIVE = y ]; then
		echo "                                   sudo granted"
	else
		echo "                                   sudo not granted"
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
echo "Shutdown after finishing:          ${SHUTDOWN_NOW}"
echo ""
echo "Type 'alias' in terminal after the reboot to see new aliases."
echo "You can remove Debian Deployment Helper from your disk after rebooting"
echo ""
echo "Script will start working on your system after this prompt."
echo "Time needed for completion depends on your system and internet speed"
echo ""
read -p "Press enter to continue or Ctrl+C to abort " foo

#Script starts actual work here
clear

#Amend sources.list, sources contain contrib and non-free mirrors
echo "
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free

deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free" > /etc/apt/sources.list

#Connect to the internet by establishing connection
echo "Establishing connection and updating the system..."
dhclient
apt update
apt upgrade -y

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

#Create log
./data/98_log.sh

#Shutdown section
	if [ $SHUTDOWN_NOW = y ]; then
		shutdown now
	else
		echo ""
		echo "Script has finished, please reboot your system..."
	fi

echo ""
