#!/bin/bash
FLD=$(date "+%d-%m-%C%y_%H:%M:%S")
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
mkdir -p "./${FLD}"
cp -R ./speedtest-result/*.log ./${FLD}/
cp -R ./speedtest-result/*.json ./${FLD}/
tar -cvzf "abc.tar.gz" "${FLD}"
mv abc.tar.gz ${FLD}.tar.gz
rm -rf "./${FLD}/"
TOK=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
CONTENT=$(cat ${FLD}.tar.gz | base64)
curl -i -X PUT -H "Authorization: token ${TOK}" -d "{\"message\": \"Test results from ${SRL_NO}\", \"content\":\"${CONTENT}\" }" "https://api.github.com/repos/benlycos/automation-results/contents/${SRL_NO}/${FLD}.tar.gz"
rm -rf ${FLD}.tar.gz
