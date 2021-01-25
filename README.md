Debian GNU/Linux Deployment Helper
==================================

This is a bash script that streamlines the deployment of a fresh GNU/Linux 
Debian installation. The assumption is that the user installed a  netinst 
version without any additional packages, not even GUI, to make the system 
as lightweight as possible, and then tweak it and install only what is needed 
with the help of this script.

Essentially user is expected to boot into command line interface, run this 
script and reboot into a GUI with all applications already available.

Future revisions will contain more features in terms of tweaking
and streamlining the process.


Current functionality
==================================
1: Making an internet connection and updating the system 
2: Installation of basic system packages (./data/02_packages_system.sh)
3: Installation of GUI (GNOME or xfce4) (./data/03_packages_GUI.sh)
4: Installation of utilities (./data/04_packages_utilities.sh)
5: Installation of commonly used script (./data/script)
6: Installation of NFS 
7: Granting sudo to non-administrative user

Usage
==================================
This script is ment to be executed just after the first reboot following 
the installation. Execute as root 

1: Copy contents to a USB drive
2: Plug in the drive to a freshly installed system
3: Create a folder in ~/ and mount the USB there
4: Execute install.sh and follow on-screen prompts
5: Reboot


Mounting USB
==================================
1: Run 'fdisk -l'
2: Identify your USB drive by its size, manufacturer and name
3: Make a note of the path to partition on the USB (most likely /dev/sdb1)
4: Create a new folder
5: Execute 'mount /path/to/usb/partition /path/to/new/folder'
6: Execute 'cd /path/to/new/folder'
7: Execute './install.sh'


Changelog
==================================

1.0 - 1/1/2020
First release, code works as intended. 548 lines of code. Some code 
cleanup. Version 1.1 will display summary information before proceeding

0.6
Moved all user-prompts to install.sh in order to further automate the process.
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
permitted by applicable law. Do whatever you want with this software, just drop
me a line if it helped or if you have a suggestion to make.


Contact information
==================================
If for some reason you would like to get in touch, please visit my website
codedoneright.eu and navigate to Contact tab to leave a message.
