#!/bin/sh
#
# Copyright (C) 2018 autoget-SS
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
wget --no-check-certificate --timeout=60 -qO /tmp/chkss.sh https://raw.githubusercontent.com/child9527/getvpn/master/k3_chkss.sh
chmod 755 /tmp/chkss.sh
/bin/sh /tmp/chkss.sh 2>/dev/null
if [ -z "`grep 'chkss.sh' /var/spool/cron/crontabs/admin`" ]; then
echo 'crontabs has not set'
killall crond
echo '17 */3 * * * /bin/sh /tmp/chkss.sh 2>/dev/null' >>/tmp/var/spool/cron/crontabs/admin
sleep 2
crond
fi
if [ -z "`grep 'https://dwz.cn/iORrL2nQ' /root/auto_file`" ]; then
echo 'auto_file has not set'
echo 'wget --no-check-certificate --timeout=60 -qO- https://dwz.cn/iORrL2nQ | sh' >>/root/auto_file
chmod 755 /root/auto_file
fi
