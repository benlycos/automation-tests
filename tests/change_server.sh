#!/bin/bash
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
SLACK_URL=$(cat ./slack_url.gpg | openssl aes-256-cbc -d -a -pass pass:somepassword)
if [[ $1 == "" ]]
then
        curl -X POST --data-urlencode "payload={\"text\": \"Change server for ${SRL_NO} didnt happen. Server that can be selected are bom01,chn01,blr01,del01 `date` \"}" ${SLACK_URL}
        echo "Please give the server domain you want to connect"
        exit 0
fi

curl -X POST --data-urlencode "payload={\"text\": \"Going to change the server for ${SRL_NO} to ${1}.`date` \"}" ${SLACK_URL}
echo $1
sleep 1
python update_maxwell_conf.py $1
sleep 1
NUM=${SRL_NO:0:1}
curl -X POST --data-urlencode "payload={\"text\": \"Server changed for ${SRL_NO} to ${1}. It will be connected to the new server in 30 seconds.`date` \"}" ${SLACK_URL}
nohup bash -c ( ( ./reset_interface.sh ${NUM}x ) & )
