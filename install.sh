#!/bin/bash

clear

echo ""
echo "Debian Deployment Helper for Debian GNU/Linux 10 Buster"
echo ""
echo "Before proceeding make sure that your PC is connected to your router via"
echo "cable. This script assumes cable connection for the initial system setup."
echo "You can connect to WiFi after the reboot, when you boot into a desktop"
echo "environment of your choice"
echo ""
echo "Changelog and additional information is available in read.me file"
echo ""

read -p "Press enter to continue or Ctrl+C to abort " foo


#Collect information from user

#Check if user wants to install GUI, if no GUI is installed utilities will not
#be installed as well as they require GUI
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

#ADD SUMMARY AND PROMPT USER TO CHECK IS ALL IS OK

#Export variables for use with other modules
export GUI_SELECT
export SCRIPT_INSTALL
export SCRIPT_USER
export SHARE_INSTALL
export SHARE_USER
export SHARE_FOLDER
export SHARE_PATH

#Start execution of script

#Amend sources.list
echo "
deb http://deb.debian.org/debian buster main contrib non-free
deb-src http://deb.debian.org/debian buster main contrib non-free

deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

deb http://deb.debian.org/debian buster-updates main contrib non-free
deb-src http://deb.debian.org/debian buster-updates main contrib non-free" > /etc/apt/sources.list

echo ""
echo "/etc/apt/sources.list file has been amended to contain contrib and non-free mirrors"

echo ""
echo "Establishing connection and updating the system..."

#Connect to the internet by establishing connection 
dhclient

#Update and upgrade your system
apt update 
apt upgrade -y 

#Install system and additional commonly used packages
./data/02_packages_system.sh
./data/03_packages_GUI.sh
./data/04_packages_utilities.sh

#Install useful script and create aliases
./data/05_add_script.sh

#Amend fstab for network shares
./data/06_shares.sh

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

#Reboot section
echo ""
echo "Script has finished, unless you want to do something else, please reboot"

read -p "Would you like to reboot now? (y/n): " REBOOT_NOW

	if [ $REBOOT_NOW = y ]; then
		reboot
	else
		echo ""
		echo "After you are done, please reboot your system"
	fi

echo ""
echo "Script is finished, enjoy your new system!"
