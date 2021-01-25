#!/bin/bash

if [ $GUI_SELECT = g ]; then
	
	apt install evince -y
	apt install gparted -y
	apt install htop -y
	apt install kate -y
	apt install vlc -y
	apt install zip -y
	apt install lollypop -y
	apt install synaptic -y
	apt install xpaint -y
	apt install spyder3 -y
	apt install libreoffice -y
	apt install gimp -y

	apt install chromium -y
	apt install chrome-gnome-shell -y
	apt install filezilla -y
	apt install thunderbird -y
	apt install mumble -y

elif [ $GUI_SELECT = x ]; then

	apt install evince -y
	apt install gparted -y
	apt install htop -y
	apt install kate -y
	apt install vlc -y
	apt install zip -y
	apt install rhythmbox -y
	apt install synaptic -y
	apt install xpaint -y
	apt install spyder3 -y
	apt install libreoffice -y
	apt install gimp -y

	apt install chromium -y
	apt install filezilla -y
	apt install thunderbird -y
	apt install mumble -y
	

#No packages, skip this module entirely
else

	echo ""
	echo "No utilities will be installed"

fi

echo ""
echo "Moving to next module..."
