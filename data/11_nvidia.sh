#!/bin/bash

if [ $NVIDIA_DRIVERS = y ]; then
	apt install nvidia-driver -y
	apt install firmware-misc-nonfree -y
	echo "nVidia drivers installed" >> ${DDH_LOG}

else
	echo ""
fi

