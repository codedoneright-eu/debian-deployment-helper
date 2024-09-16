#!/bin/bash
# This module adds Signal repository
# To remove repository at a later date do the following:
# 1: sudo apt-key list
# 2: identify Signal key
# 3: sudo apt-key del <Signal key>
# 4: delete /etc/apt/sources.list.d/signal.list

if [ $SIGNAL = y ]; then
	wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
	cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

	echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
	sudo tee /etc/apt/sources.list.d/signal-xenial.list

	echo "Signal repository added" >> ${DDH_LOG}

else
	echo ""
fi

