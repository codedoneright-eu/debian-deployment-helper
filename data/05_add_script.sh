#!/bin/bash

if [ $SCRIPT_INSTALL = y ]; then

	mkdir /var/zzz_script || echo "Folder already exists, please investigate..."
	cp ./data/script/*.sh /var/zzz_script/
	chown ${SCRIPT_USER}:${SCRIPT_USER} -R /var/zzz_script/
	chmod +x -R /var/zzz_script/
	echo "alias cdr_backup='/var/zzz_script/cdr_backup.sh'" >> /home/${SCRIPT_USER}/.bash_aliases
	echo "alias cdr_pwd='/var/zzz_script/cdr_pwd.sh'" >> /home/${SCRIPT_USER}/.bash_aliases
	echo "alias cdr_ssh='/var/zzz_script/cdr_ssh.sh'" >> /home/${SCRIPT_USER}/.bash_aliases
	echo "alias cdr_sync='/var/zzz_script/cdr_sync.sh'" >> /home/${SCRIPT_USER}/.bash_aliases

	echo ""
	echo "Commonly used script has been installed in /var/zzz_script/"

else

	echo ""
	echo "No script will be installed"

fi

echo ""
echo "Moving to next module..."
