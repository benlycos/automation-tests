#!/bin/bash
BOX_KEY=$1
TMP_DIR=$(mktemp -d -t watchy-XXXXXXXXXX)
TOK=$(wget -q https://raw.githubusercontent.com/benlycos/automation-tests/main/tests/key.gpg -O - | openssl aes-256-cbc -d -a -pass pass:somepassword)
curl -s --header "Authorization: token $TOK" --header 'Accept: application/vnd.github.v3.raw'  -o "${TMP_DIR}/$1" --location "https://api.github.com/repos/benlycos/box-keys/contents/$1"
echo $3 > ${TMP_DIR}/cmd
USER_CMD=$(cat ${TMP_DIR}/cmd)
FINAL_CMD="nohup bash -c \"( ( ${USER_CMD} ) & )\" "
sudo chmod 400 ${TMP_DIR}/$1
echo $FINAL_CMD >  ${TMP_DIR}/final_cmd
ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no  -i $TMP_DIR/$1 watchy@$2 "nohup bash -c \"( ( ${USER_CMD} ) & )\" "
rm -rf ${TMP_DIR}
