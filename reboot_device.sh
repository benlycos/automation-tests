#!/bin/bash
TMP_DIR=$(mktemp -d -t watchy-XXXXXXXXXX)
wget -qc -O ${TMP_DIR}/main.tar.gz https://github.com/benlycos/automation-tests/archive/refs/heads/main.tar.gz > ${TMP_DIR}/all.log
tar -xvf ${TMP_DIR}/main.tar.gz -C ${TMP_DIR}
# Doing to the folder in which all the scripts are present. Scripts can only properly run in the tests folder so be in this folder before running the script
cd ${TMP_DIR}/automation-tests-main/tests/
chmod +x *.sh
./reboot_device.sh
