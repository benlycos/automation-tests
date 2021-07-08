P_IP=$(cat /etc/openvpn/servers/pa-1194/logs/openvpn-status.log | grep $1 | tail -n 1 | sed -e 's/,.*/\ /g')
echo $P_IP
