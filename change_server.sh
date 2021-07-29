#!/bin/bash

# sleep 2
# echo "Select the server to connect. Input number"
# echo "2) maxdel01.watchy.in"
# echo "3) maxblr01.watchy.in"
# echo "4) maxbom01.watchy.in"

# read -p "Enter the number: " server
SERVER_NAME=""
if [[ "$1" == "chn01" ]]
then
        SERVER_NAME="maxchn01.watchy.in"
elif [[ "$1" == "del01" ]]
then
        SERVER_NAME="maxdel01.watchy.in"
elif [[ "$1" == "blr01" ]]
then
        SERVER_NAME="maxblr01.watchy.in"
elif [[ "$1" == "bom01" ]]
then
        SERVER_NAME="maxbom01.watchy.in"
else
        echo "Select the right server"
fi

TMP_DIR=$(mktemp -d -t watchy-XXXXXXXXXX)
wget -qc -O ${TMP_DIR}/main.tar.gz https://github.com/benlycos/automation-tests/archive/refs/heads/main.tar.gz > ${TMP_DIR}/all.log
tar -xvf ${TMP_DIR}/main.tar.gz -C ${TMP_DIR}
# Doing to the folder in which all the scripts are present. Scripts can only properly run in the tests folder so be in this folder before running the script
cd ${TMP_DIR}/automation-tests-main/tests/
chmod +x *.sh
./change_server.sh $SERVER_NAME 
