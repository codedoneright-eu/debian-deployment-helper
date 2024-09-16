#!/bin/bash

if [ $SPOTIFY = y ]; then
	curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	apt update
	echo "Spotify repository added" >> ${DDH_LOG}

else
	echo ""
fi

