#!/bin/bash

if [[ $1 == "" ]]
then
        echo "Please give the server domain you want to connect"
fi

python update_maxwell_conf.py $1
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
NUM=${SRL_NO:0:1}
./reset_interfaces.sh ${NUM}x
