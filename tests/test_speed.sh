#!/bin/bash

RAN_STR=$3

if [[ $2 == "3x" ]]
then
        USB_PORTS="1-1,1-2,1-3"
        USB_PORTS1="1-1,1-2,1-3"
        BOX=3
fi

if [[ $2 == "5x" ]]
then
        USB_PORTS="2-3,1-4,1-5,1-7,1-2"
        USB_PORTS1="1-3,1-4,1-5,1-7,1-2"
        BOX=5
fi

if [[ $2 == "8x" ]]
then
        USB_PORTS="1-1.2,1-1.4.2.2,1-1.4.2.4,1-1.4.3.1,1-1.4.3.2,1-1.4.3.3,1-1.4.3.4,1-1.1"
        USB_PORTS1="1-1.2,1-1.4.2.2,1-1.4.2.4,1-1.4.3.1,1-1.4.3.2,1-1.4.3.3,1-1.4.3.4,1-1.1"
        BOX=8
fi

echo "Running tests on ${BOX}x"

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
        ip route | grep "default" | grep -q "net$i"
        if [[ "$?" == "0" ]]
        then
                DIS_PORTS=""
                for j in $(seq 0 "$(($BOX - 1))")
                do
                        if [[ "$i" != "$j" ]]
                        then
                                ip route | grep "default" | grep -q "net$j"
                                if [[ "$?" == "0" ]]
                                then
                                        PORT_BLK=$(echo "${USB_PORTS}" | cut -d"," -f$(($j + 1)))
                                        PORT_BLK1=$(echo "${USB_PORTS1}" | cut -d"," -f$(($j + 1)))
                                        DIS_PORTS="${DIS_PORTS}${j},"
                                        echo "${PORT_BLK}" | sudo tee /sys/bus/usb/drivers/usb/unbind || true
                                        echo "${PORT_BLK1}" | sudo tee /sys/bus/usb/drivers/usb/unbind || true
                                fi
                        fi
                done
                sleep 1
                route -n > ./speedtest-result/net$i--$1--$RAN_STR.log
                sleep 1
                python speedtest.py $measure --json > ./speedtest-result/net$i--$1--$RAN_STR.json
                DIS_PORTS=${DIS_PORTS::-1}
                for k in $(seq 1 $BOX)
                do
                        echo $DIS_PORTS | grep -q $(($k - 1))
                        if [[ "$?" == "0" ]]
                        then
                                PORT_ENA=$(echo "${USB_PORTS}" | cut -d"," -f$k)
                                PORT_ENA1=$(echo "${USB_PORTS1}" | cut -d"," -f$k)
                                echo "${PORT_ENA}" | sudo tee /sys/bus/usb/drivers/usb/bind || true
                                echo "${PORT_ENA1}" | sudo tee /sys/bus/usb/drivers/usb/bind || true
                                sleep 2
                                sudo wvdial --config=./wvdial.conf pppd$(($k - 1)) reboot
                                ip route | grep "default" | grep -q "net$(($k - 1))"
                                STAT=$?
                                while [ "$STAT" != "0" ] 
                                do
                                        sleep 2
                                        ip route | grep "default" | grep -q "net$(($k - 1))"
                                        STAT=$?
                                done
                        fi
                done
                sleep 5
        fi
done

