#!/bin/bash

if [ $VPN_INSTALL = y ]; then
	VPN_CONF=$(find ./data/vpn/ -name "*.conf" | awk -F\/ '{print $4}')
	mkdir /home/${USERNAME_INSTALL}/.vpn
	cp ./data/vpn/* /home/${USERNAME_INSTALL}/.vpn/
	chown ${USERNAME_INSTALL}:${USERNAME_INSTALL} -R /home/${USERNAME_INSTALL}/.vpn/
	chmod +x -R /home/${USERNAME_INSTALL}/.vpn/
	echo "alias cdr_vpn='cd ~/.vpn/ && sudo openvpn --config ${VPN_CONF} --daemon'" >> /home/${USERNAME_INSTALL}/.bash_aliases

	echo "VPN connection is available via 'cdr_vpn' alias" >> ${DDH_LOG}

else
	echo ""
fi

