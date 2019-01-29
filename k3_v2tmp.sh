#!/bin/sh
#
# Copyright (C) 2018 autoget-SS
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
wget --no-check-certificate --timeout=60 -qO /tmp/chkv2.sh https://raw.githubusercontent.com/child9527/getvpn/master/k3_chkv2.sh
chmod 755 /tmp/chkv2.sh
/bin/sh /tmp/chkv2.sh
if [ -z "`grep 'chkv2.sh' /var/spool/cron/crontabs/admin`" ]; then
echo 'start set crontabs'
killall crond
echo '17 */3 * * * /bin/sh /tmp/chkv2.sh 2>/dev/null' >>/tmp/var/spool/cron/crontabs/admin
sleep 2
crond
fi
if [ -z "`grep 'https://dwz.cn/ZZUEJ2CH' /root/auto_file`" ]; then
echo 'start set autofile'
echo 'wget --no-check-certificate --timeout=60 -qO- https://dwz.cn/ZZUEJ2CH | sh' >>/root/auto_file
chmod 755 /root/auto_file
fi
