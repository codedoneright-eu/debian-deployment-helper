#!/bin/bash

case "$1" in


-h)

echo "
cdr_pwd - password creation script

Provides a random password from the combination of the following: [1-9], [a-z], 
[A-Z] and [!@#$%&]. Password length is random, from 13 to 20 characters. For the
sake of convenience it will not use the following characters '0,i,l,o,I'

Usage: cdr_pwd.sh [OPTION] [#]


  -m	provide multiple passwords, requires specifying the amount with -m #, 
    	where # is the number of passwords to create
  -h	show this help
  
You can use output redirection to create a file containing multiple passwords.
E.g. 'cdr_pwd.sh -m 100 >> ~/pwd'. This will create a file named 'pwd' in user's
home directory containing 100 fresh and random passwords.

Contact information - <https://codedoneright.eu/?page_id=40>"

;;

-m)

	for i in `seq $2`;
	do
		choose() { echo ${1:RANDOM%${#1}:1} $RANDOM; }

		{
    		choose '!@#$%&'
    		choose '123456789'
    		choose 'abcdefghjkmnpqrstuvwxyz'
    		choose 'ABCDEFGHJKLMNPQRSTUVWXYZ'
    		for i in $( seq 1 $(( 8 + RANDOM % 8 )) )
    		do
        		choose '123456789abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ'
    		done

		} | sort -R | awk '{printf "%s",$1}'
		echo ""
	done
;;

*)

choose() { echo ${1:RANDOM%${#1}:1} $RANDOM; }

{
    choose '!@#$%&'
    choose '123456789'
    choose 'abcdefghjkmnpqrstuvwxyz'
    choose 'ABCDEFGHJKMNPQRSTUVWXYZ'
    for i in $( seq 1 $(( 8 + RANDOM % 8 )) )
    do
        choose '123456789abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ'
    done

} | sort -R | awk '{printf "%s",$1}'
echo ""
;;

esac
