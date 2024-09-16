#!/usr/bin/expect -f

#Provide login data by replacing relevant string
set CDR_USERNAME "put_username_here"
set CDR_IP "put_server_IP_here"
set CDR_PW "put_password_here"

spawn ssh $CDR_USERNAME@$CDR_IP
expect "assword:"
send "$CDR_PW\r"
interact

