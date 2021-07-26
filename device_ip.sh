#!/bin/bash

ALL_P_IP=$(cat /etc/openvpn/servers/pa-1194/logs/openvpn-status.log | grep $1 | grep -v "^pa" | cut -d"," -f1)
for  P_IP in $ALL_P_IP
do

        if [ "${P_IP}" = "" ]
        then
                echo "NOTHING"
                exit 0
        else
                nc -vz -w 1 $P_IP 22 &> /dev/null
                if [ $? -eq 0 ]
                then
                        echo $P_IP
                        exit 0
                fi
                echo "NOTHING"
                exit 0
        fi
done
