#!/bin/bash

#This will install GNOME desktop environment
if [ $GUI_SELECT = g ]; then

	apt install gnome -y 
	apt install gnome-tweaks -y 
	apt install gnome-shell-extensions -y 
	apt install gnome-shell-extension-manager -y
	echo "Installed GNOME desktop" >> ${DDH_LOG}


#This will install XFCE4 desktop environment - incomplete
elif [ $GUI_SELECT = x ]; then

	apt install xfce4 -y
	apt install xfce4-power-manager -y
	apt install xfce4-screenshooter -y
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
	echo "Installed XFCE4 desktop" >> ${DDH_LOG}

else
	apt install gnome -y 
	apt install gnome-tweaks -y 
	apt install gnome-shell-extensions -y 
	apt install gnome-shell-extension-manager -y
	echo "Installed GNOME desktop" >> ${DDH_LOG}
fi

