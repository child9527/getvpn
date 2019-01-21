#!/bin/sh
#
# Copyright (C) 2018 autoget-v2ray
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
# This is free script, for help you auto synchronization local ip address and domain name.
wget --no-check-certificate --timeout=60 -qO /root/chkv2.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2p_mtk_chkv2.sh
chmod 777 /root/chkv2.sh
/bin/sh /root/chkv2.sh 2>/dev/null
sed -i 2i\ '5 0,12 * * * /bin/sh /root/chkv2.sh 2>/dev/null' /etc/crontabs/root
sed -i 3a\ '/bin/sh /root/chkv2.sh 2>/dev/null' /etc/rc.local
