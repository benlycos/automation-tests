#!/bin/bash


if [[ $1 == "3x" ]]
then
        USB_PORTS="1-1,1-2,1-3"
        USB_PORTS1="1-1,1-2,1-3"
        BOX=3
fi

if [[ $1 == "5x" ]]
then
        USB_PORTS="2-3,1-4,1-5,1-7,1-2"
        USB_PORTS1="1-3,1-4,1-5,1-7,1-2"
        BOX=5
fi

if [[ $1 == "8x" ]]
then
        USB_PORTS="1-1.2,1-1.4.2.2,1-1.4.2.4,1-1.4.3.1,1-1.4.3.2,1-1.4.3.3,1-1.4.3.4,1-1.1"
        USB_PORTS1="1-1.2,1-1.4.2.2,1-1.4.2.4,1-1.4.3.1,1-1.4.3.2,1-1.4.3.3,1-1.4.3.4,1-1.1"
        BOX=8
fi


if [[ "$1" == "" ]]
then
        echo "Get the box type"
        exit 1
fi

DIS_PORTS=""

for i in $(seq 0 "$(($BOX - 1))")
do
        ip route | grep "default" | grep -q "net$i"
        if [[ "$?" == "0" ]]
        then
                PORT_BLK=$(echo "${USB_PORTS}" | cut -d"," -f$(($i + 1)))
                PORT_BLK1=$(echo "${USB_PORTS1}" | cut -d"," -f$(($i + 1)))
                DIS_PORTS="${DIS_PORTS}${i},"
                echo "${PORT_BLK}" | sudo tee /sys/bus/usb/drivers/usb/unbind || true
                echo "${PORT_BLK1}" | sudo tee /sys/bus/usb/drivers/usb/unbind || true
        fi
done
sudo supervisorctl restart findingmaxwell
sleep 2

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
        fi
done
