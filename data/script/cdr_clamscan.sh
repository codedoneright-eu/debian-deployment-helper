#!/bin/bash
LOG=/var/zzz_script/clamav_scan.log
MYLOG=/var/zzz_script/clamav_mylog.log

FIND="$(which find)"
DATE="$(which date)"
GREP="$(which grep)"

TIMESTAMP=`$DATE '+%Y-%m-%d %H:%M'`

if [[ ! -e /tmp/virus ]]; then
  mkdir /tmp/virus
fi

check_scan () {
if [ `tail -n 12 ${LOG} | $GREP Infected | $GREP -v 0 | wc -l` != 0 ]
then
echo "$TIMESTAMP VIRUS DETECTED"
1>> $MYLOG
echo "`tail -n 50 ${LOG}`" 1>> $MYLOG
echo "#####################################"
1>> $MYLOG
else
echo "$TIMESTAMP - scan has been performed as expected" 1>> $MYLOG
fi
}

clamscan -r / --move=/tmp/virus --max-filesize=600M --max-scansize=600M --exclude-dir=/sys/ --exclude-dir=/home/jakub/HDD_N/ --exclude-dir=/home/jakub/Torrent/ --quiet --infected --log=${LOG}
check_scan
