P_IP=$(sudo cat /etc/openvpn/servers/pa-1194/logs/openvpn-status.log | grep $1 | tail -n 1 | sed -e 's/,.*/\ /g')
while ! ping -c1 $P_IP &>/dev/null
        do echo "Ping Fail - `date`"
done
echo "Host Found - `date`"
