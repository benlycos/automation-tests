#!/bin/bash
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
SLACK_URL=$(cat ./slack_url.gpg | openssl aes-256-cbc -d -a -pass pass:somepassword)
curl -X POST --data-urlencode "payload={\"text\": \"Device ${SRL_NO} going to get restarted `date` \"}" ${SLACK_URL}
reboot -n now
