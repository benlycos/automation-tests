P_IP=$(sudo cat /etc/openvpn/servers/pa-1194/logs/openvpn-status.log | grep $1 | tail -n 1 | sed -e 's/,.*/\ /g')
ping -q -n 1 $P_IP
echo $?
echo $P_IP
