#!/bin/bash

#NOT FUNCTIONAL YET, just copies to user's ~/ for now

cp ./data/wallpaper/* /home/${USERNAME_INSTALL}/
echo "If you put wallpapers in the folder they have been copied" >> ${DDH_LOG}
