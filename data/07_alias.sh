#!/bin/bash
# This module adds some bash aliases

	echo "alias cdr_update='sudo apt update && apt list --upgradable'" >> /home/${SCRIPT_USER}/.bash_aliases
	echo "alias cdr_upgrade='sudo apt upgrade -y'" >> /home/${SCRIPT_USER}/.bash_aliases

echo ""
echo "Moving to next module..."
