Debian Deployment Helper for GNU/Linux Debian 11 (Buster)
==================================
This is a bash script that streamlines the deployment of a fresh GNU/Linux 
Debian 11. The assumption is that the user installed a netinst version without
any additional packages, not even GUI, to make the system as lightweight as 
possible, and then tweak it with the help of this script.

User is expected to boot into command line interface, run this script and reboot
into a GUI with all applications and additional features already available.


Current functionality
==================================
1: Establish internet connection, amend sources.list and update the system
2: Install system packages (/data/02_packages_system.sh)
3: Install GUI (GNOME or xfce4) (/data/03_packages_GUI.sh)
4: Install utilities (/data/04_packages_utilities.sh)
5: Option to install additional script (/data/script)
6: Install NFS
7: Grant sudo to default user
8: Option to add VPN
9: Leave log file for default user in ~/ddh-log.txt


Usage
==================================
This script is ment to be executed after the reboot following the installation.
Execute as root

1: Copy contents of this folder to a USB drive
2: If using VPN, copy all relevant files, to ./data/vpn/ folder before running 
   the script, it needs *.conf and other relevant files to be placed there
3: Plug USB drive to a freshly installed system
4: Create a folder in ~/ and mount the USB there
5: Execute install.sh and follow on-screen prompts
6: On completion, remove the USB and boot to your new system


Mounting USB
==================================
1: Run 'fdisk -l'
2: Identify your USB drive by its size, manufacturer or name
3: Make a note of the path to the partition on the USB
   Most likely /dev/sdb1 or /dev/sda1 if system installed on NVMe
4: Create a new folder 
5: Mount USB in that folder
6: Enter that folder
7: Execute './install.sh'
8: If unable to execute, chmod +x ~/created_folder_after_mount


Example of use, execute commands as root
==================================
mkdir ddh
mount /dev/sdb1 ~/ddh
chmod +x -R ~/ddh
cd ddh
./install.sh


Changelog
==================================
1.4 - 4/09/2021
VPN module fix
Code and prompt cleanup
read.me cleanup
638 lines of code

1.3 - 3/09/2021
Introduced a VPN module
Introduced a log file, will be found in ~/ddh-log.txt
Script installs everything for user uid=1000
Changed reboot to shutdown at the end of the script
Code cleanup

1.2 - 31/08/2021
Introduced a summary before script execution
Code cleanup
read.me cleanup
Feature to add: log file in ~/

1.1 - 24/08/2021
Updated for Debian 11
Moved aliases to a new module

1.0 - 1/1/2020
First public release, code works as intended
548 lines of code 
Code cleanup
Feature to add: display summary information before proceeding

0.6
Moved all user-prompts to install.sh
Script asks user for data before execution of tasks

0.5
Some code cleanup (more verbose prompts)

0.4
Added shares module

0.3
GUI module allows for selection between GNOME and xfce4

0.2
Divided the script into modules, each performing a specific task

0.1
Initial commit


Legal information
==================================
Debian Deployment Helper comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law. Do whatever you want with this software, you can
drop me a line if it helped or if you have a suggestion.


Contact information
==================================
If you would like to get in touch, please visit <codedoneright.eu> and navigate
to Contact tab to leave a message.
