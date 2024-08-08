#!/bin/bash

read -p "username: " NICK
read -p "password: " PASSWORD
read -p "insert nc server port: " PORT
read -p "insert destination's port: " DESTINATION

listen() {
while true
do
nc -l $PORT | openssl aes-256-cbc -md sha512 -d -a -pbkdf2 -pass pass:$PASSWORD -iter 1000000
done
}

write() {
while true
do
read MESSAGE
echo $NICK: $MESSAGE | openssl aes-256-cbc -md sha512 -a -pbkdf2 -salt -pass pass:$PASSWORD -iter 1000000 | nc -N localhost $DESTINATION
done
}

listen &
write
