#!/bin/bash
TMP_DIR=$(mktemp -d -t watchy-XXXXXXXXXX)
wget -qc -O ${TMP_DIR}/main.tar.gz https://github.com/benlycos/automation-tests/archive/refs/heads/main.tar.gz > ${TMP_DIR}/all.log
# sleep 1
# PID=$(cat all.log | grep "pid" | tr -d -c 0-9)
# echo $PID >> ${TMP_DIR}/all.log
# timeout 20 tail --pid=$PID -f /dev/null
tar -xvf ${TMP_DIR}/main.tar.gz -C ${TMP_DIR} >> ${TMP_DIR}/all.log
# Doing to the folder in which all the scripts are present. Scripts can only properly run in the tests folder so be in this folder before running the script
cd ${TMP_DIR}/automation-tests-main/tests/
chmod +x *.sh
./run_tests.sh ap >> ${TMP_DIR}/all.log
