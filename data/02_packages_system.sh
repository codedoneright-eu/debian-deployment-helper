#!/bin/bash

#System packages

#Better system search, useage "axi-cache search <pkg-name>"
apt install apt-xapian-index -y
apt install bash-completion -y
apt install cifs-utils -y
apt install sudo -y
apt install expect -y 
apt install openvpn -y 
apt install wget -y 
apt install curl -y 
apt install software-properties-common -y 

echo "System packages have been installed" >> ${DDH_LOG}

