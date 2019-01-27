#!/bin/sh
wget --no-check-certificate --timeout=60 --user-agent="Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)" -qO /tmp/isd.txt https://c.ishadowx.net/
if [ "$?" == "0" ]; then
rport=`cat /tmp/isd.txt | grep '"portsga"'| cut -d':' -f2 | cut -d'>' -f2`
lport=`awk '{print substr($0,52,5)}' /tmp/media/data/ssr.conf | cut -d'"' -f1`
	if [ "$lport" != "$rport" ]; then
	echo '参数不匹配，执行更新设置'
	portsga=`cat /tmp/isd.txt | grep '"portsga"'| cut -d':' -f2 | cut -d'>' -f2`
	ipsga=`cat /tmp/isd.txt | grep '"ipsga"' | awk '{print substr($0,49,10)}'`
	pwsga=`cat /tmp/isd.txt | grep '"pwsga"'| cut -d':' -f2 | cut -d'>' -f2`
	ssrcfg=`echo '{"name":"sga","ip":"'$ipsga'","type":"1","port":"'$portsga'","encrypt":"rc4-md5","ssencrypt":"aes-256-cfb","v2encrypt":"auto","v2uuid":"1-2-3-4-5","v2alertid":"0","v2level":"0","v2type":"0","timeout":"60","password":"'$pwsga'","obfs":"plain","protocol":"origin","obfspara":"","propara":""}'`
	/bin/sh /root/set_ssr.sh 1 1 0 1 $ssrcfg
	else
	echo '参数一致'
	fi
echo '下载成功'
else
echo '下载失败，等待网络连接'
fi
