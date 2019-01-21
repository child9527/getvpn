#!/bin/sh
#
# Copyright (C) 2018 autoget-v2ray
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
# This is free script, for help you auto synchronization local ip address and domain name.
wget --no-check-certificate --timeout=60 -qO /root/chkv2.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2p_mtk_chkv2.sh?token=AebyKBGpDgcbZrmgc2ihdbAFVIN-teAyks5cRZe7wA%3D%3D
chmod 777 /root/chkv2.sh
nohup /bin/sh /root/chkv2.sh >/dev/null 2>&1 &
echo '5 0,12 * * * /bin/sh /root/chkv2.sh 2>/dev/null' >>/etc/crontabs/root
sed -i 3a\ 'nohup /bin/sh /root/chkv2.sh >/dev/null 2>&1 &' /etc/rc.local
