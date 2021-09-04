#!/bin/bash
# Create log file with script summary

touch /home/${USERNAME_INSTALL}/ddh-log.txt
chown ${USERNAME_INSTALL}:${USERNAME_INSTALL} /home/${USERNAME_INSTALL}/ddh-log.txt

DDH_LOG=/home/${USERNAME_INSTALL}/ddh-log.txt

echo "Debian Deployment Helper log
============================" >> ${DDH_LOG}

echo "Quick system update and upgrade available via 'cdr_update' and 
'cdr_upgrade' commands in CLI
" >> ${DDH_LOG}

#Add note if user granted sudo
if [ $SUDO_GIVE = y ]; then
	echo "User ${USERNAME_INSTALL} has been granted sudo privilege" >> ${DDH_LOG}
else
	echo "User ${USERNAME_INSTALL} has not been granted sudo privilege" >> ${DDH_LOG}
fi

#Add note which desktop has been installed
if [ $GUI_SELECT = g ]; then
	echo "Installed GNOME desktop" >> ${DDH_LOG}
elif [ $GUI_SELECT = x ]; then
	echo "Installed XFCE4 desktop" >> ${DDH_LOG}
else
	echo "Desktop and utilities have not been installed" >> ${DDH_LOG}
fi

#Add note if script has been installed
if [ $SCRIPT_INSTALL = y ]; then
	echo "Useful script has been installed in /var/zzz_script/ folder" >> ${DDH_LOG}
else
	echo ""
fi

#Add note if share has been installed
if [ $SHARE_INSTALL = y ]; then
	echo "Network share has been mounted in ~/${SHARE_FOLDER}" >> ${DDH_LOG}
else
	echo ""
fi

#Add note if VPN has been installed
if [ $VPN_INSTALL = y ]; then
	echo "VPN connection is accesible from CLI via cdr_vpn alias" >> ${DDH_LOG}
else
	echo ""
fi

#Write out installed packages
echo "
Following packages have been installed:" >> ${DDH_LOG}
awk '$3~/^install$/ {print $4;}' /var/log/dpkg.log >> ${DDH_LOG}
