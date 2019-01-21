#!/bin/sh
wget --no-check-certificate --timeout=60 -qO /etc/storage/chkss.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2_pdn_chkss.sh
chmod 777 /etc/storage/chkss.sh
/bin/sh /etc/storage/chkss.sh
if [ -z "`grep '/etc/storage/chkss.sh' /etc/storage/cron/crontabs/admin`" ]; then
sed -i 1a\ '17 */3 * * * /bin/sh /etc/storage/chkss.sh 2>/dev/null' /etc/storage/cron/crontabs/admin
fi
if [ -z "`grep '/etc/storage/chkss.sh' /etc/storage/post_wan_script.sh`" ]; then
echo '/bin/sh /etc/storage/chkss.sh 2>/dev/null' >>/etc/storage/post_wan_script.sh
fi
