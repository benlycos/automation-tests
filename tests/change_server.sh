#!/bin/bash
SLACK_URL=$(cat ./slack_url.gpg | openssl aes-256-cbc -d -a -pass pass:somepassword)
if [[ $1 == "" ]]
then
        curl -X POST --data-urlencode "payload={\"text\": \"Change server for ${SLK_KEY} didnt happen. Server that can be selected are bom01,chn01,blr01,del01 `date` \"}" ${SLACK_URL}
        echo "Please give the server domain you want to connect"
        exit 0
fi

python update_maxwell_conf.py $1
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
NUM=${SRL_NO:0:1}
./reset_interface.sh ${NUM}x
