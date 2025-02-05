#!/bin/bash

if [ $GITHUB = y ]; then
	wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'

	echo "GitHub desktop repository added" >> ${DDH_LOG}
	echo "Install with - sudo apt install github-desktop" >> ${DDH_LOG}

else
	echo ""
fi

