#!/bin/bash

RAN_STR=$3

if [[ $2 == "3x" ]]
then
        USB_PORTS="1-1,1-2,1-3"
        BOX=3
fi
if [[ "$1" == "" ]]
then
        echo "either pass upload or download to measure bandwidth"
        exit 1
fi
if [[ $1 == "upload" ]]
then
        measure="--no-download"
        delimiter_str="Upload"
fi

if [[ $1 == "download" ]]
then
        measure="--no-upload"
        delimiter_str="Download"
fi

for i in $(seq 0 "$(($BOX - 1))")
do
        ls /sys/class/net | grep -q "net$i"
        if [[ "$?" == "0" ]]
        then
                echo ""
                echo "testing"
                echo net$i
                DIS_PORTS=""
                for j in $(seq 0 "$(($BOX - 1))")
                do
                        if [[ "$i" != "$j" ]]
                        then

                                ls /sys/class/net | grep -q "net$j"
                                if [[ "$?" == "0" ]]
                                then
                                        PORT_BLK=$(echo $USB_PORTS | cut -d"," -f$(($j + 1)))
                                        DIS_PORTS="${DIS_PORTS}${j},"
                                        echo $PORT_BLK | sudo tee /sys/bus/usb/drivers/usb/unbind || true
                                fi
                        fi
                done
                route -n > ./speedtest-result/net$i--$1--$RAN_STR.log
                sleep 1
                curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - $measure >> ./speedtest-result/net$i--$1--$RAN_STR.log
                DIS_PORTS=${DIS_PORTS::-1}
                for k in $(seq 1 $BOX)
                do
                        echo $DIS_PORTS | grep -q $(($k - 1))
                        if [[ "$?" == "0" ]]
                        then
                                PORT_ENA=$(echo $USB_PORTS | cut -d"," -f$k)
                                echo $PORT_ENA | sudo tee /sys/bus/usb/drivers/usb/bind || true
                                ls /sys/class/net | grep -q "net$(($k - 1))"
                                STAT=$?
                                while [ "$STAT" != "0" ] 
                                do
                                        sleep 5
                                        ls /sys/class/net | grep -q "net$(($k - 1))"
                                        STAT=$?
                                done
                        fi
                done
        fi
done

