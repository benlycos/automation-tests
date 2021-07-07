#!/bin/bash

if [[ $1 == "" ]]
then
        echo "Please give the server domain you want to connect"
fi

python update_configuration.py $1
SRL_NO=$(cat /opt/watchy/bond007-id/serial.number)
NUM=${SRL_NO:0:1}
./reset-interfaces.sh ${NUM}x
