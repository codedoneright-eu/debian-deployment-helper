#!/bin/bash

if [ $SHARE_INSTALL = y ]; then

	mkdir /home/${USERNAME_INSTALL}/${SHARE_FOLDER}
	chown ${USERNAME_INSTALL}:${USERNAME_INSTALL} -R /home/${USERNAME_INSTALL}/${SHARE_FOLDER}

	echo "${SHARE_PATH}	/home/${USERNAME_INSTALL}/${SHARE_FOLDER}	cifs	uid=1000,guest,rw,users,nofail	0	0" >> /etc/fstab

	echo "Network share has been mounted in ~/${SHARE_FOLDER}" >> ${DDH_LOG}
	echo "To add additional share go to /etc/fstab" >> ${DDH_LOG}

else
	echo ""
fi

