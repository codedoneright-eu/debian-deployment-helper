#!/bin/bash
# This module adds some bash aliases

echo "alias cdr_update='sudo apt update && apt list --upgradable'" >> /home/${USERNAME_INSTALL}/.bash_aliases
echo "alias cdr_upgrade='sudo apt upgrade -y'" >> /home/${USERNAME_INSTALL}/.bash_aliases
