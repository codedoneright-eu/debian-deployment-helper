#!/bin/bash

DATE="$(which date)"
TIMESTAMP=`$DATE '+%Y.%m.%d'`

export WORK_DIR=`pwd`

echo ""
echo "Linux Backup and Restore Helper"

echo ""
echo "Hello $USER, Please follow on-screen instructions"
echo ""
echo "This script creates and restores backups of a drive, sudo is required"
echo "To find out drive letters run 'sudo fdisk -l' and identify your drive"
echo "Script works from current working directory."
echo ""
echo "Please select function..."
echo "b: Make a backup"
echo "r: Restore a backup"
echo "q: quit"
echo ""

read -p "What would you like to do (b/r/q): " PART

if [ $PART = b ]; then

    echo ""
    echo "This part will make a backup." 
    echo "Which device would you like to clone?"
    
    read -p "Please provide the letter (sdX): " DRIVE_B
    
    echo ""
    echo "Cloning /dev/sd${DRIVE_B}"
    echo ""
    echo "Output file name structure is NAME_${TIMESTAMP}.zip"
    
    read -p "Please specify NAME part: " NAMEB
    
    echo ""
    echo "Output file will be named ${NAMEB}_${TIMESTAMP}.zip"
    echo ""
    echo "This will take a while. Please wait... "
    echo ""

    sudo dd if=/dev/sd${DRIVE_B} of=${NAMEB}_${TIMESTAMP}.img conv=noerror status=progress

    echo ""
    echo "Compressing ${NAMEB}_${TIMESTAMP}.img, please wait..."
    
    zip ${NAMEB}_$TIMESTAMP.zip ${NAMEB}_${TIMESTAMP}.img

    echo ""
    echo "Removing ${NAMEB}_${TIMESTAMP}.img"
    
    sudo rm ${NAMEB}_${TIMESTAMP}.img

    SIZE="$(du -h ${NAMEB}_${TIMESTAMP}.zip | awk '{ print $1 }')"

    echo ""
    echo "The file ${NAMEB}_${TIMESTAMP}.zip is about ${SIZE}."
    echo "Full file path is ${WORK_DIR}/${NAMEB}_${TIMESTAMP}.zip"

elif [ $PART = r ]; then

    echo ""
    echo "This part will restore a backup."
    echo ""
    echo "Script looks for input file with the following pattern NAME_YYYY.MM.DD.zip"
    echo ""
    echo "To which device would you like to write?"
    
    read -p "Please provide the letter (sdX): " DRIVE_R
    
    echo ""
    echo "Which file you want to restore?"
    
    read -p "Please specify NAME part of the name: " NAMER
    read -p "Please specify YYYY part of the name: " YEAR
    read -p "Please specify MM   part of the name: " MONTH
    read -p "Please specify DD   part of the name: " DAY

    echo ""
    echo "Unzipping ${NAMER}_${YEAR}.${MONTH}.${DAY}.zip" 
    echo "This will take a while. Please wait..."
    echo ""
    
    unzip ${NAMER}_${YEAR}.${MONTH}.${DAY}.zip

    echo ""
    echo "Writing ${NAMER}_${YEAR}.${MONTH}.${DAY}.img to /dev/sd${DRIVE_R}"
    echo "This will take a while. Please wait..."
    
    sudo dd if=${NAMER}_${YEAR}.${MONTH}.${DAY}.img of=/dev/sd${DRIVE_R} conv=noerror status=progress

    echo ""
    echo "Removing ${NAMER}_${YEAR}.${MONTH}.${DAY}.img"
    
    sudo rm ${NAMER}_${YEAR}.${MONTH}.${DAY}.img

    echo ""
    echo "Drive /dev/sd${DRIVE_R} is ready for use"

else

    echo ""

fi

echo ""
echo "Done."
