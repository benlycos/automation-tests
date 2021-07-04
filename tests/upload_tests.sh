#!/bin/bash
FLD=$(date "+%d-%m-%C%y_%H:%M:%S")
DTE=$(date "+%d-%m-%C")
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
mkdir -p "./${FLD}"
cp -R ./speedtest-result/*.log ./${FLD}/
cp -R ./speedtest-result/*.json ./${FLD}/
tar -czf "abc.tar.gz" "${FLD}"
mv abc.tar.gz ${FLD}.tar.gz
rm -rf "./${FLD}/"
TOK=$(cat key.gpg | openssl aes-256-cbc -d -a -pass pass:somepassword)
CONTENT=$(base64 ${FLD}.tar.gz)
MSGG="Test results from ${SRL_NO}"
URL="https://api.github.com/repos/benlycos/automation-results/contents/${DTE}/${SRL_NO}/${FLD}.tar.gz"
python upload_tests.py "${TOK}" "${CONTENT}" "${MSGG}" "${URL}"
echo "https://github.com/benlycos/automation-results/blob/main/${DTE}/${SRL_NO}/${FLD}.tar.gz" > ./speedtest-result/uploaded_link--$1.txt
rm -rf ${FLD}.tar.gz
SLACK_URL=$(cat ./slack_url.gpg | openssl aes-256-cbc -d -a -pass pass:somepassword)
python send_slack.py "Test ended and results uploaded. Report available at https://benlycos.github.io/automation-results/report/?file-path=${DTE}/${SRL_NO}/${FLD}.tar.gz for ${SRL_NO} at $(date)" "${SLACK_URL}"
