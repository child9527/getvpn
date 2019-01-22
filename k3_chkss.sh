#!/bin/sh
wget --no-check-certificate --timeout=60 --user-agent="Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)" -qO /tmp/isd.txt https://c.ishadowx.net/
if [ "$?" == "0" ]; then
lport=`awk '{print substr($0,53,5)}' /tmp/media/nand/ssr_new.conf | cut -d'"' -f1`
rport=`cat /tmp/isd.txt | grep '"portsgc"'| cut -d':' -f2 | cut -d'>' -f2`
ssr_index=`nvram get ssr_index`
	if [ "$ssr_index" == "0" ] && [ "$lport" == "$rport" ]; then
		echo 'vpn is not running'
		nvram set ssr_index=1
		/bin/sh /root/ssrcmd.sh start
		exit
	fi
	if [ "$lport" != "$rport" ]; then
		echo 'remote port not match,execute update...'
		portsgc=`cat /tmp/isd.txt | grep '"portsgc"'| cut -d':' -f2 | cut -d'>' -f2`
		ipsgc=`cat /tmp/isd.txt | grep '"ipsgc"' | awk '{print substr($0,49,10)}'`
		pwtmp=`cat /tmp/isd.txt | grep '"pwsgc"'| cut -d':' -f2 | cut -d'>' -f2`
		pwsgc=`echo -n $pwtmp | base64`
		ssrcfg=`echo '{"name":"c2dj","ip":"'$ipsgc'","type":"1","port":"'$portsgc'","encrypt":"rc4-md5","ssencrypt":"aes-256-cfb","v2encrypt":"auto","v2uuid":"1-2-3-4-5","v2alertid":"0","v2level":"0","v2type":"0","timeout":"60","password":"'$pwsgc'","obfs":"plain","protocol":"origin","obfspara":"","propara":""}'`
		/bin/sh /root/set_ssr.sh 0 1 0 1 $ssrcfg
	else
		echo 'everything is ok'
	fi
echo 'download succeeded'
else
echo 'download failed,please try again'
fi
