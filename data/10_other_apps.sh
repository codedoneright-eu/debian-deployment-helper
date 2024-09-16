#!/bin/bash
# This module is for proprietary apps it downloads them to your user's ~/

if [ $OTHER_APPS = y ]; then
	wget -c https://repo.steampowered.com/steam/archive/stable/steam_latest.deb
	wget -c https://download.xnview.com/XnViewMP-linux-x64.deb
	
	# Copy deb files to user's $home and change owner
	cp *.deb /home/${USERNAME_INSTALL}/
	chown ${USERNAME_INSTALL}:${USERNAME_INSTALL} /home/${USERNAME_INSTALL}/*.deb
	
	echo "Other apps downloaded to ~/" >> ${DDH_LOG}

else
	echo ""
fi

