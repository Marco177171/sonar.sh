#!/bin/bash

echo "SONAR | a simple encrypted messenger"
echo "made with <3 by studio pulsar"
echo "INITIAL SETUP"
read -p "username: " NICK
read -p "insert nc server port: " PORT
read -p "insert destination's port: " DESTINATION
read -p "password: " PASSWORD
echo SETUP COMPLETE

listen() {
	while true
	do
		nc -l $PORT | openssl aes-256-cbc -md sha512 -d -a -pbkdf2 -pass pass:$PASSWORD
	done
}

write() {
	while true
	do
		read MESSAGE
		echo $NICK: $MESSAGE | openssl aes-256-cbc -md sha512 -a -pbkdf2 -salt -pass pass:$PASSWORD | nc -N localhost $DESTINATION
	done
}

listen &
write
