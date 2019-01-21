#!/bin/sh
#
# Copyright (C) 2018 autoget-v2ray
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
# This is free script, for help you auto synchronization local ip address and domain name.
wget --no-check-certificate --timeout=60 -qO /root/chkv2.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2p_mtk_chkv2.sh
chmod 755 /root/chkv2.sh
echo 'download chkv2.sh commplete'
/bin/sh /root/chkv2.sh
if [ -z "`grep '/root/chkv2.sh' /etc/crontabs/root`" ] ; then
sed -i 1i\ '5 0,12 * * * /bin/sh /root/chkv2.sh' /etc/crontabs/root
fi
if [ -z "`grep '/root/chkv2.sh' /etc/rc.local`" ] ; then
sed -i 4i\ '/bin/sh /root/chkv2.sh' /etc/rc.local
fi
