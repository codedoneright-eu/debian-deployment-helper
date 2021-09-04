#!/bin/bash
# This module adds some bash aliases

if [ $VPN_INSTALL = y ]; then
	VPN_CONF=$(find ./data/vpn/ -name "*.conf" | awk -F\/ '{print $4}')
	mkdir /home/${USERNAME_INSTALL}/.vpn || echo "Folder already exists, please investigate..."
	cp ./data/vpn/* /home/${USERNAME_INSTALL}/.vpn/
	chown ${USERNAME_INSTALL}:${USERNAME_INSTALL} -R /home/${USERNAME_INSTALL}/.vpn/
	chmod +x -R /home/${USERNAME_INSTALL}/.vpn/
	echo "alias cdr_vpn='sudo openvpn --config /home/${USERNAME_INSTALL}/.vpn/${VPN_CONF} --daemon'" >> /home/${USERNAME_INSTALL}/.bash_aliases
else
	echo ""
fi

