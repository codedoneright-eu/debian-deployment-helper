#!/bin/bash

if [ $SCRIPT_INSTALL = y ]; then

	mkdir /var/zzz_script
	cp ./data/script/*.sh /var/zzz_script/
	chown ${USERNAME_INSTALL}:${USERNAME_INSTALL} -R /var/zzz_script/
	chmod +x -R /var/zzz_script/

	echo "alias cdr_backup='/var/zzz_script/cdr_backup.sh'" >> /home/${USERNAME_INSTALL}/.bash_aliases
	echo "alias cdr_pwd='/var/zzz_script/cdr_pwd.sh'" >> /home/${USERNAME_INSTALL}/.bash_aliases
	echo "alias cdr_ssh='/var/zzz_script/cdr_ssh.sh'" >> /home/${USERNAME_INSTALL}/.bash_aliases

	chown ${USERNAME_INSTALL}:${USERNAME_INSTALL} /home/${USERNAME_INSTALL}/.bash_aliases

	echo "Useful script has been installed in /var/zzz_script/ folder" >> ${DDH_LOG}
else
	echo ""
fi
