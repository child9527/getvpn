#!/bin/sh
ssr_index=`nvram get ssr_index`
if [ "$ssr_index" == "0" -o -z "$ssr_index" ]; then
	wget --no-check-certificate --timeout=60 -qO /tmp/v2.txt http://freev2.org
		if [ "$?" == "0" ]; then
		echo 'vpn is not running'
		nvram set ssr_index=1
		rip=`cat /tmp/v2.txt | grep Address |sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2 | cut -d'<' -f1`
		rport=`cat /tmp/v2.txt | grep '"port"'| sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2`
		ruuid=`cat /tmp/v2.txt | grep UUID | cut -d'=' -f2 | cut -d'>' -f2`
		rAlertid=`cat /tmp/v2.txt | grep AlterID |sed s/[[:space:]]//g | cut -d':' -f2 | cut -d'<' -f1`
		ssrcfg=`echo '{"name":"ZnJlZXYyLm9yZw==","ip":"'$rip'","type":"2","port":"'$rport'","encrypt":"rc4-md5","ssencrypt":"aes-256-cfb","v2encrypt":"none","v2uuid":"'$ruuid'","v2alertid":"'$rAlertid'","v2level":"0","v2type":"0","timeout":"60","password":"hello","obfs":"plain","protocol":"origin","obfspara":"","propara":""}'`
		echo 'VPN has not found,execute V2ray'
		/bin/sh /root/set_ssr.sh 1 1 0 1 $ssrcfg
		exit
		fi
	echo 'V2ray is not running, but start V2ray failed'
	exit
else
echo 'V2ray has already running'
fi

wget --no-check-certificate --timeout=60 -qO /tmp/v2.txt http://freev2.org
if [ "$?" == "0" ]; then
	lAlertid=`cat /tmp/media/nand/ssr_new.conf | awk -F '\"v2alertid\":\"' '{printf $2}' | awk -F '"' '{printf $1}'`
	lip=`cat /tmp/media/nand/ssr_new.conf | awk -F '\"ip\":\"' '{printf $2}' | awk -F '"' '{printf $1}'`
	luuid=`cat /tmp/media/nand/ssr_new.conf | awk -F '\"v2uuid\":\"' '{printf $2}' | awk -F '"' '{printf $1}'`
	lport=`cat /tmp/media/nand/ssr_new.conf | awk -F '\"port\":\"' '{printf $2}' | awk -F '"' '{printf $1}'`
	rip=`cat /tmp/v2.txt | grep Address |sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2 | cut -d'<' -f1`
	rport=`cat /tmp/v2.txt | grep '"port"'| sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2`
	ruuid=`cat /tmp/v2.txt | grep UUID | cut -d'=' -f2 | cut -d'>' -f2`
	rAlertid=`cat /tmp/v2.txt | grep AlterID |sed s/[[:space:]]//g | cut -d':' -f2 | cut -d'<' -f1`
		if [[ "$luuid" != "$ruuid" ]] || [[ "$lip" != "$rip" ]] || [[ "$lport" != "$rport" ]] || [[ "$lAlertid" != "$rAlertid" ]]; then
		echo 'config changed,execute reconfig V2ray'
		rip=`cat /tmp/v2.txt | grep Address |sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2 | cut -d'<' -f1`
		rport=`cat /tmp/v2.txt | grep '"port"'| sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2`
		ruuid=`cat /tmp/v2.txt | grep UUID | cut -d'=' -f2 | cut -d'>' -f2`
		rAlertid=`cat /tmp/v2.txt | grep AlterID |sed s/[[:space:]]//g | cut -d':' -f2 | cut -d'<' -f1`
		#alias=`echo 'freev2.org' | base64`
		ssrcfg=`echo '{"name":"ZnJlZXYyLm9yZw==","ip":"'$rip'","type":"2","port":"'$rport'","encrypt":"rc4-md5","ssencrypt":"aes-256-cfb","v2encrypt":"none","v2uuid":"'$ruuid'","v2alertid":"'$rAlertid'","v2level":"0","v2type":"0","timeout":"60","password":"hello","obfs":"plain","protocol":"origin","obfspara":"","propara":""}'`
		/bin/sh /root/set_ssr.sh 1 1 0 1 $ssrcfg
		else
		echo 'config has not change'
		fi
echo 'download succeeded'
else
echo 'download failed,please try again'
fi
