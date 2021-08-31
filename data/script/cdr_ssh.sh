#!/usr/bin/expect -f

#Provide login data by changing foo to relevant string
USER=foo
IP=foo
PASSWORD=foo

spawn ssh ${USER}@${IP}
expect "assword:"
send "${PASSWORD}\r"
interact
