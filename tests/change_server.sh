#!/bin/bash
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
SLACK_URL=$(cat ./slack_url.gpg | openssl aes-256-cbc -d -a -pass pass:somepassword)
if [[ $1 == "" ]]
then
        curl -X POST --data-urlencode "payload={\"text\": \"Change server for ${SRL_NO} didnt happen. Server that can be selected are bom01,chn01,blr01,del01 `date` \"}" ${SLACK_URL}
        echo "Please give the server domain you want to connect"
        exit 0
fi

curl --output /dev/null --silent --head --fail -X POST --data-urlencode "payload={\"text\": \"Going to change the server for ${SRL_NO} to ${1}.`date` \"}" ${SLACK_URL}
echo $?
sleep 1
python update_maxwell_conf.py $1
sleep 1
NUM=${SRL_NO:0:1}
./reset_interface.sh ${NUM}x

until $(curl --output /dev/null --silent --head --fail -X POST --data-urlencode "payload={\"text\": \"Change server for ${SRL_NO} has happened successfully to ${1}.`date` \"}" ${SLACK_URL}); do
    printf '.'
    sleep 5
done
