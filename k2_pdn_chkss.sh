#!/bin/sh

setss() {
nvram set ss_enable=0
nvram commit
sleep 5
nohup /bin/sh /etc/storage/script/sh_emi.sh >/dev/null 2>&1 &
sleep 60
nvram set ss_server=$1
nvram set ss_server_port=$2
nvram set ss_key=$3
nvram set ss_method=aes-256-cfb
nvram set ss_server2=$4
nvram set ss_s2_port=$5
nvram set ss_s2_key=$6
nvram set ss_s2_method=aes-256-cfb
nvram set ss_mode_x=1
nvram set kcptun2_enable2=0
nvram set ss_DNS_Redirect=1
nvram set ss_enable=1
nvram commit
sleep 5
nohup /bin/sh /etc/storage/script/sh_emi.sh >/dev/null 2>&1 &
}
net=`nvram get ss_internet`
if [ "$net" != "1" ]; then
	wget --no-check-certificate --timeout=60 --user-agent="Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)" -qO /tmp/isd.txt http://isx.yt/
	if [ "$?" == "0" ]; then
	echo 'lost ss status,update...'
	portsgc=`cat /tmp/isd.txt | grep '"portsgc"'| cut -d':' -f2 | cut -d'>' -f2`
	ipsgc=`cat /tmp/isd.txt | grep '"ipsgc"' | awk -F '\"\>' '{printf $2}' | awk -F '\<' '{printf $1}'`
	pwsgc=`cat /tmp/isd.txt | grep '"pwsgc"'| cut -d':' -f2 | cut -d'>' -f2`
	portsga=`cat /tmp/isd.txt | grep '"portsga"'| cut -d':' -f2 | cut -d'>' -f2`
	ipsga=`cat /tmp/isd.txt | grep '"ipsga"' | awk -F '\"\>' '{printf $2}' | awk -F '\<' '{printf $1}'`
	pwsga=`cat /tmp/isd.txt | grep '"pwsga"'| cut -d':' -f2 | cut -d'>' -f2`
	setss $ipsgc $portsgc $pwsgc $ipsga $portsga $pwsga
	echo `date` >>/tmp/tmp.txt
	else
	echo 'download failed,please try again.'
	fi
else
echo 'everything is ok'
fi
