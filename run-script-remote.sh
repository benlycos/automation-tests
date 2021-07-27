#!/bin/bash
BOX_KEY=$1
TMP_DIR=$(mktemp -d -t watchy-XXXXXXXXXX)
TOK=$(wget -q https://raw.githubusercontent.com/benlycos/automation-tests/main/tests/key.gpg -O - | openssl aes-256-cbc -d -a -pass pass:somepassword)
curl -s --header "Authorization: token $TOK" --header 'Accept: application/vnd.github.v3.raw'  -o "${TMP_DIR}/$1" --location "https://api.github.com/repos/benlycos/box-keys/contents/$1"
ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no  -i $TMP_DIR/$1 watchy@$2
touch $TMP_DIR/hello
