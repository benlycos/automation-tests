RAN_STR=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
NUM=${SRL_NO:0:1}
echo "testing aggregation for ${NUM}x"
mkdir -p ./speedtest-result
mkdir -p ./speedtest-result/old_test
mv ./speedtest-result/*.log ./speedtest-result/old_test/
./test_speed.sh upload ${NUM}x $RAN_STR
sleep 5
./test_speed.sh download ${NUM}x $RAN_STR
