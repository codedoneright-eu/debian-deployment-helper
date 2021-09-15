#!/bin/bash

if [ $NVIDIA_DRIVERS = y ]; then
	apt install nvidia-driver 
	apt install firmware-misc-nonfree
	echo "nVidia drivers installed" >> ${DDH_LOG}
else
	echo ""
fi

