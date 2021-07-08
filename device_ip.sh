#!/bin/bash
P_IP=$(sudo cat /etc/openvpn/servers/pa-1194/logs/openvpn-status.log | grep $1 | tail -n 1 | sed -e 's/,.*/\ /g')
if [ "${P_IP}" = "" ]
then 
        echo "NOTHING"
        exit 0
else 
        while ! ping -c1 $P_IP &>/dev/null
        do 
                echo "NOTHING"
                exit 0
        done
        echo $P_IP
fi
