#!/bin/bash
TMP_DIR=$(mktemp -d -t watchy-XXXXXXXXXX)
wget -bqc -O ${TMP_DIR}/main.tar.gz https://github.com/benlycos/automation-tests/archive/refs/heads/main.tar.gz > ${TMP_DIR}/wget.log
tar -xvf ${TMP_DIR}/main.tar.gz -C ${TMP_DIR}
# Doing to the folder in which all the scripts are present. Scripts can only properly run in the tests folder so be in this folder before running the script
cd ${TMP_DIR}/automation-tests-main/tests/
chmod +x *.sh
./run_tests.sh ap
