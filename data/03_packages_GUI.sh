#!/bin/bash

#This will install GNOME desktop environment
if [ $GUI_SELECT = g ]; then

	echo ""
	echo "Installing GNOME..."
	apt install gnome -y
	apt install gnome-shell-extensions -y
	apt install gnome-tweak-tool -y
	apt install gpaste -y
	apt install gnome-shell-extensions-gpaste -y
	apt install gnome-tweak -y
	apt install gnome-tweaks -y

#This will install XFCE4 desktop environment
elif [ $GUI_SELECT = x ]; then

	echo ""
	echo "Installing XFCE4..."
	apt install xfce4 -y
	apt install xfce4-power-manager -y
	apt install lightdm -y
	apt install slick-greeter -y
	apt install nm-tray -y
	apt install gnome-terminal -y
	apt install gedit -y
	apt install pasystray -y
	apt install galculator -y
	apt install nautilus -y
	apt install xfce4-clipman -y
	apt purge gnome-keyring -y

#No packages, skip this module entirely
else

	echo ""
	echo "No GUI will be installed"

fi

echo ""
echo "Moving to next module..."
