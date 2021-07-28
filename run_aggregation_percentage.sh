#!/bin/bash
DIR_NAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 5 ; echo '')
mkdir -p /tmp/$DIR_NAME
wget https://github.com/benlycos/automation-tests/archive/refs/heads/main.tar.gz -O /tmp/$DIR_NAME/main.tar.gz
tar -xvf /tmp/$DIR_NAME/main.tar.gz -C /tmp/$DIR_NAME
# Doing to the folder in which all the scripts are present. Scripts can only properly run in the tests folder so be in this folder before running the script
cd /tmp/$DIR_NAME/automation-tests-main/tests/
chmod +x *.sh
./run_tests.sh ap
