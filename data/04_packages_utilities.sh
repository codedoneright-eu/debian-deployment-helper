#!/bin/bash

if [ $GUI_SELECT = g ]; then
	
	apt install evince -y
	apt install gparted -y
	apt install htop -y
	apt install kate -y
	apt install vlc -y
	apt install zip -y
	apt install rhythmbox -y
	apt install spyder3 -y
	apt install libreoffice -y

	apt install firefox-esr -y
	apt install filezilla -y
	apt install thunderbird -y

elif [ $GUI_SELECT = x ]; then

	apt install evince -y
	apt install gparted -y
	apt install htop -y
	apt install kate -y
	apt install vlc -y
	apt install zip -y
	apt install rhythmbox -y
	apt install spyder3 -y
	apt install libreoffice -y

	apt install firefox-esr -y
	apt install filezilla -y
	apt install thunderbird -y

else
	echo ""
fi
