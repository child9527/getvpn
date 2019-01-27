#!/bin/sh
#
# Copyright (C) 2018 autoget-SS
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
wget --no-check-certificate --timeout=60 -qO /tmp/chkss.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2p_brc_chkss.sh
chmod 777 /tmp/chkss.sh
/bin/sh /tmp/chkss.sh 2>/dev/null
if [ -z "`grep '/tmp/chkss.sh' /var/spool/cron/crontabs/admin`" ]; then
sed -i 1i\ '17 */3 * * * /bin/sh /tmp/chkss.sh 2>/dev/null' /tmp/media/data/cron_file
killall crond 
cp -f /tmp/media/data/cron_file /var/spool/cron/crontabs/admin
sleep 2
crond
fi
if [ -z "`grep 'https://dwz.cn/A81I92Al' /tmp/media/data/auto_file`" ]; then
sed -i 1i\ 'wget --no-check-certificate --timeout=60 -qO- https://dwz.cn/A81I92Al | sh' /tmp/media/data/auto_file
fi
