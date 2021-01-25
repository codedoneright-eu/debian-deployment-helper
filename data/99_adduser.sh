#!/usr/bin/expect -f

#This module is not implemented, thinking if it is even necessary at all 

read -p "Please provide new username " NEW_USERNAME
read -p "Please provide password " NEW_PASSWORD

#Add new user
spawn sudo adduser ${NEW_USERNAME}
expect "assword:"
send "${NEW_PASSWORD}\r"
expect "assword:"
send "${NEW_PASSWORD}\r"
expect "[]:"
send "\r"
expect "[]:"
send "\r"
expect "[]:"
send "\r"
expect "[]:"
send "\r"
expect "[]:"
send "\r"
expect "[Y/n]"
send "y\r"
interact
