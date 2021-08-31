#!/bin/bash

clear

echo ""
echo "Debian Deployment Helper for Debian GNU/Linux 11 Buster"
echo ""
echo "Before proceeding make sure that your PC is connected to your router via"
echo "cable. This script assumes cable connection for the initial system setup."
echo "You can connect to WiFi after the reboot."
echo ""
echo "Changelog and additional information available in read.me file"
echo ""

read -p "Press enter to continue or Ctrl+C to abort " foo


#Collect information from user
echo ""
echo "Please answer a few questions so that the script can tailor the experience"
echo "for your needs. If you refuse to install desktop environment no utilities"
echo "will be installed, as they rely on a GUI."

#Check if user wants to install GUI, if no GUI is installed utilities will not
#be installed
echo ""
echo "Please choose desktop environment..."
echo "GNOME - g"
echo "xfce4 - x"
echo "Skip GUI installation - no"

echo ""
read -p "Which GUI woud you like to install (g/x/no)? " GUI_SELECT

#Check if user wants to install commonly used script
echo ""
read -p "Would you like to install commonly used script (y/n)? " SCRIPT_INSTALL

	if [ $SCRIPT_INSTALL = y ]; then
		echo ""
		echo "Please provide information for the account on this system..."
		read -p "Username: " SCRIPT_USER
	else
		echo ""
		echo "Script will not be installed..."
	fi

#Check if the user wants to add a network share
echo ""
read -p "Would you like to mount a network share (y/n)? " SHARE_INSTALL

	if [ $SHARE_INSTALL = y ]; then
		echo ""
		echo "Please provide information for the account on this system..."
		read -p "Username: " SHARE_USER
		read -p "Folder name for the share: " SHARE_FOLDER
		read -p "Network share path: " SHARE_PATH
	else
		echo ""
		echo "Network share will not be installed..."
	fi

#Grant sudo to a non-administrative user
echo ""
read -p "Would you like to add your non-administrative user to sudo group (y/n): " SUDO_GIVE

	if [ $SUDO_GIVE = y ]; then
		echo ""
		read -p "Please specify which user: " SUDO_USER
		usermod -aG sudo ${SUDO_USER}
		echo "User ${SUDO_USER} has been added to the sudo group"
	else
		echo ""
		echo "No user has been added to sudo group"
	fi

#Ask user if wants to reboot when finished
echo ""
read -p "Would you like to reboot when finished? (y/n): " REBOOT_NOW

#Export variables for use with other modules
export GUI_SELECT
export SCRIPT_INSTALL
export SCRIPT_USER
export SHARE_INSTALL
export SHARE_USER
export SHARE_FOLDER
export SHARE_PATH

#Display summary
echo ""
echo "Desktop to be installed:           ${GUI_SELECT}"
echo "Commonly used script installation: ${SCRIPT_INSTALL}"
echo "Script installation for user:      ${SCRIPT_USER}"
echo "Install shares:                    ${SHARE_INSTALL}"
echo "NFS share user:                    ${SHARE_USER}"
echo "NFS share folder:                  ${SHARE_FOLDER}"
echo "NFS share path:                    ${SHARE_PATH}"
echo "Reboot after finishing:            ${REBOOT_NOW}"
echo ""
echo "Type 'alias' in terminal after the reboot to see new aliases"
echo "You remove Debian Deployment Helper from your disk after the reboot."

echo ""
read -p "Press enter to continue or Ctrl+C to abort " foo

#Script starts working here

#Amend sources.list
#Sources contain contrib and non-free mirrors
echo "
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free

deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free" > /etc/apt/sources.list

echo ""
echo "/etc/apt/sources.list file has been amended to contain contrib and non-free mirrors"

#Connect to the internet by establishing connection
echo ""
echo "Establishing connection and updating the system..."
dhclient
apt update
apt upgrade -y

#Install system and additional commonly used packages
./data/02_packages_system.sh
./data/03_packages_GUI.sh
./data/04_packages_utilities.sh

#Install useful script and create aliases for them
./data/05_add_script.sh

#Amend fstab for network shares
./data/06_shares.sh

#Add aliases
./data/07_alias.sh

#Reboot section
	if [ $REBOOT_NOW = y ]; then
		reboot
	else
		echo ""
		echo "Please reboot your system"
	fi

#All done
echo ""
echo "Enjoy your new system!"
