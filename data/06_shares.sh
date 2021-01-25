#!/bin/bash

if [ $SHARE_INSTALL = y ]; then

	mkdir /home/${SHARE_USER}/${SHARE_FOLDER}
	chown ${SHARE_USER}:${SHARE_USER} -R /home/${SHARE_USER}/${SHARE_FOLDER}
	
	echo "${SHARE_PATH}	/home/${SHARE_USER}/${SHARE_FOLDER}	cifs	uid=1000,guest,rw,users,nofail	0	0" >> /etc/fstab
	
	echo ""
	echo "Network share has been mounted for ${SHARE_USER} in ~/${SHARE_FOLDER}"
	echo "nofail option ensures no boot-loop if the share is unavailable"

else
	echo ""
	echo "No shares will be mounted"

fi

echo ""
echo "Moving to next module..."
