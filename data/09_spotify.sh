#!/bin/bash
# This module adds spotify repository
# To remove repository at a later date do the following:
# 1: sudo apt-key list
# 2: identify spotify key
# 3: sudo apt-key del <spotify key>
# 4: delete /etc/apt/sources.list.d/spotify.list

if [ $SPOTIFY = y ]; then
	curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	apt update
	echo "Spotify repository added, you can install it via		apt install spotify-client" >> ${DDH_LOG}

else
	echo ""
fi

