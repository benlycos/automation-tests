#!/bin/bash
RAN_STR=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
NUM=${SRL_NO:0:1}
echo "testing aggregation for ${NUM}x"
mkdir -p ./speedtest-result
mkdir -p ./speedtest-result/old_test
mv ./speedtest-result/*.log ./speedtest-result/old_test/
mv ./speedtest-result/*.json ./speedtest-result/old_test/
mv ./speedtest-result/*.txt ./speedtest-result/old_test/
SERVER_IP=$(curl -s checkip.amazonaws.com)
./test_speed.sh upload ${NUM}x $RAN_STR
route -n > ./speedtest-result/all--upload--$RAN_STR.log
python speedtest.py --no-download --json > ./speedtest-result/all--upload--$RAN_STR.json

sleep 5

./test_speed.sh download ${NUM}x $RAN_STR
route -n > ./speedtest-result/all--download--$RAN_STR.log
python speedtest.py --no-upload --json > ./speedtest-result/all--download--$RAN_STR.json

sleep 5

python cal_aggregation.py $RAN_STR
./upload_tests.sh ${RAN_STR}
