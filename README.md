Debian GNU/Linux Deployment Helper
==================================

This is a bash script that streamlines the deployment of a fresh GNU/Linux 
Debian installation. The assumption is that the user installed a netinst 
version without any additional packages, not even GUI, to make the system 
as lightweight as possible, and then tweak it and install only what is needed 
with the help of this script.

User is expected to boot into command line interface, run this 
script and reboot into a GUI with all applications already available.

Future versions will contain more features in terms of tweaking
and streamlining the process.


Current functionality
==================================
1: Establish internet connection and update the system 
2: Install some system packages (/data/02_packages_system.sh)
3: Install GUI (GNOME or xfce4) (/data/03_packages_GUI.sh)
4: Install utilities (/data/04_packages_utilities.sh)
5: Install commonly used script (/data/script)
6: Install NFS 
7: Grant sudo to non-administrative user

Usage
==================================
This script is ment to be executed after the reboot following the installation.
Execute as root

1: Copy contents of this folder to a USB drive
2: Plug in the drive to a freshly installed system
3: Create a folder in ~/ and mount the USB there
4: Execute install.sh and follow on-screen prompts


Mounting USB
==================================
1: Run 'fdisk -l'
2: Identify your USB drive by its size, manufacturer and name
3: Make a note of the path to the partition on the USB 
   Most likely /dev/sdb1 or /dev/sda1 if system installed on NVMe
4: Create a new folder (eg. 'mkdir ddh')
5: Execute 'mount /path/to/usb/partition /path/to/new/folder'
6: Execute 'cd /path/to/new/folder'
7: Execute './install.sh'
   If unable to execute script, run "chmod +x -R /path/to/new/folder/"


Changelog
==================================
1.2 - 31/08/2021
Added a summary before script execution
Code cleanup
read.me cleanup

1.1 - 24/08/2021
Updated sources for Debian 11
Moved aliases to a new module

1.0 - 1/1/2020
First public release, code works as intended. 548 lines of code. Some code 
cleanup. Version 1.1 will display summary information before proceeding

0.6
Moved all user-prompts to install.sh in order to further automate the process
User is now asked all questions first to gather data for script execution 
up until whether to grant sudo and reboot

Sudo will not be granted automatically

0.5
Some code cleanup, more verbose prompts

0.4
Added shares module

0.3
Packages module now allows for selection between GNOME and xfce4, xfce selection
installs some GNOME packages (terminal, text editor, calculator)

0.2
Divided the script into modules, each performing a specific part, 
eg. installation of packages, adding commonly used script etc.

0.1
Initial commit


Legal information
==================================
Debian Deployment Helper comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law. Do whatever you want with this software, just
drop me a line if it helped or if you have a suggestion.


Contact information
==================================
If for some reason you would like to get in touch, please visit
codedoneright.eu and navigate to Contact tab to leave a message.
