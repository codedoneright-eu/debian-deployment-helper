#!/bin/bash
# This module adds spotify repository
# To remove repository at a later date do the following:
# 1: sudo apt-key list
# 2: identify spotify key
# 3: sudo apt-key del <spotify key>
# 4: delete /etc/apt/sources.list.d/spotify.list

if [ $SPOTIFY = y ]; then
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
	apt update
	echo "Spotify repository added" >> ${DDH_LOG}
else
	echo ""
fi

