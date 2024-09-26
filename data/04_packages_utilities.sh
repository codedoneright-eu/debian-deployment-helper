#!/bin/bash

if [ $GUI_SELECT = g ]; then

	apt install evince -y 
	apt install gparted -y 
	apt install htop -y 
	apt install kate -y 
	apt install vlc -y 
	apt install zip -y 
	apt install spyder -y 

	apt install gimp -y 
	apt install mcomix -y 
	apt install shotcut -y 
	apt install obs-studio -y 
	apt install dolphin-emu -y 

	apt install firefox-esr -y 
	apt install filezilla -y 
	apt install thunderbird -y 

	apt install clamav -y 
	apt install clamtk -y 
	
	echo "Utilities have been installed" >> ${DDH_LOG}

elif [ $GUI_SELECT = x ]; then

	apt install evince -y
	apt install gparted -y
	apt install htop -y
	apt install kate -y
	apt install vlc -y
	apt install zip -y
	apt install spyder -y

	apt install gimp -y
	apt install mcomix -y
	apt install shotcut -y
	apt install obs-studio -y
	apt install dolphin-emu -y

	apt install firefox-esr -y
	apt install filezilla -y
	apt install thunderbird -y

	apt install clamav -y
	apt install clamtk -y

else

	apt install evince -y
	apt install gparted -y
	apt install htop -y
	apt install kate -y
	apt install vlc -y
	apt install zip -y
	apt install spyder -y

	apt install gimp -y
	apt install mcomix -y
	apt install shotcut -y
	apt install obs-studio -y
	apt install dolphin-emu -y

	apt install firefox-esr -y
	apt install filezilla -y
	apt install thunderbird -y

	apt install clamav -y
	apt install clamtk -y

	echo "Utilities have been installed" >> ${DDH_LOG}
fi

