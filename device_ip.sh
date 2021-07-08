#!/bin/bash
P_IP=$(cat /etc/openvpn/servers/pa-1194/logs/openvpn-status.log | grep $1 | tail -n 1 | sed -e 's/,.*/\ /g')
if [ "${P_IP}" = "" ]
then 
        echo "NOTHING"
        exit 0
else 
        ping -c1 $P_IP > /dev/null
        if [ $? -eq 0 ]
        then 
                echo $P_IP
                exit 0
        fi
        echo "NOTHING"
        exit 0
fi
