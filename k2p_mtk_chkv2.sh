#!/bin/sh
# Copyright (C) 2018 autoget-v2ray
# Copyright (C) 2018 child9527 <child9527@qq.com>
# This is free script, for help you get free v2ray account to break GFW.

cfg=`uci get shadowsocksr.global.global_server`
if [ "$cfg" == "nil" ] ;then
	wget --no-check-certificate --timeout=60 -qO /tmp/wy.txt http://freev2.org
	if [ "$?" == "0" ]; then
	rip=`cat /tmp/wy.txt | grep Address |sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2 | cut -d'<' -f1`
	rport=`cat /tmp/wy.txt | grep '"port"'| sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2`
	ruuid=`cat /tmp/wy.txt | grep UUID | cut -d'=' -f2 | cut -d'>' -f2`
	rAlertid=`cat /tmp/wy.txt | grep AlterID |sed s/[[:space:]]//g | cut -d':' -f2 | cut -d'<' -f1`
	uci set shadowsocksr.global.global_server='cfg024a8f'
	uci set shadowsocksr.cfg024a8f.type='2'
	uci set shadowsocksr.cfg024a8f.server=$rip
	uci set shadowsocksr.cfg024a8f.v2alertid=$rAlertid
	uci set shadowsocksr.cfg024a8f.server_port=$rport
	uci set shadowsocksr.cfg024a8f.v2uuid=$ruuid
	uci commit
	uci set shadowsocksr.global.server_index='1'
	/etc/init.d/shadowsocksr restart
	echo 'VPN has not found,execute V2ray'
	exit 0
	fi
echo 'V2ray is not running, but start V2ray failed'
exit 0
else
echo 'V2ray has already running'
fi

wget --no-check-certificate --timeout=60 -qO /tmp/wy.txt http://freev2.org
if [ "$?" == "0" ]; then
	luuid=`uci get shadowsocksr.@servers[0].v2uuid`
	ruuid=`cat /tmp/wy.txt | grep UUID | cut -d'=' -f2 | cut -d'>' -f2`
	lip=`uci get shadowsocksr.@servers[0].server`
	rip=`cat /tmp/wy.txt | grep Address |sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2 | cut -d'<' -f1`
	lport=`uci get shadowsocksr.@servers[0].server_port`
	rport=`cat /tmp/wy.txt | grep '"port"'| sed s/[[:space:]]//g | cut -d'=' -f2 | cut -d'>' -f2`
	lAlertid=`uci get shadowsocksr.@servers[0].v2alertid`
	rAlertid=`cat /tmp/wy.txt | grep AlterID |sed s/[[:space:]]//g | cut -d':' -f2 | cut -d'<' -f1`
		if [[ "$luuid" != "$ruuid" ]] || [[ "$lip" != "$rip" ]] || [[ "$lport" != "$rport" ]] || [[ "$lAlertid" != "$rAlertid" ]]; then
		echo 'config changed,execute reconfig V2ray'
		uci set shadowsocksr.global.global_server='cfg024a8f'
		uci set shadowsocksr.cfg024a8f.type='2'
		uci set shadowsocksr.cfg024a8f.server=$rip
		uci set shadowsocksr.cfg024a8f.v2alertid=$rAlertid
		uci set shadowsocksr.cfg024a8f.server_port=$rport
		uci set shadowsocksr.cfg024a8f.v2uuid=$ruuid
		uci commit
		uci set shadowsocksr.global.server_index='1'
		/etc/init.d/shadowsocksr restart
		else
		echo 'config has not change'
		fi
echo '/tmp/wy.txt was donwload'
else
echo 'download /tmp/wy.txt failed,please try again...'
fi
