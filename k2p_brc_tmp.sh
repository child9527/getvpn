#!/bin/sh
#
# Copyright (C) 2018 autoget-SS
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
echo 站点每三个小时更新一次端口、密码，每天八次。
echo '更新时间为0:15、3:15…………19:15、21:15'
echo '脚本会自动在crontabs里添加 17 */3 * * * /bin/sh /tmp/chkss.sh 2>/dev/null'
echo 当然，能够获得此脚本，自然都是我很好的朋友。请不要将脚本外传
echo 使用的人一多，首先是速度会受影响。其次网站知名度高了之后，难保不被直接墙掉。
echo 此脚本完成于2019年大年初五，前后花费十五分钟。祝您春节愉快。您的朋友：达昆西
echo 按任意键开始或按ctrl+C中止运行
read -n 1
echo 开始运行，请等待至多2分钟
wget --no-check-certificate --timeout=60 -qO /tmp/chkss.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2p_brc_chkss.sh
chmod 777 /tmp/chkss.sh
if [ -z "`grep '/tmp/chkss.sh' /var/spool/cron/crontabs/admin`" ]; then
echo '17 */3 * * * /bin/sh /tmp/chkss.sh 2>/dev/null' >>/tmp/media/data/cron_file
killall crond 
cp -f /tmp/media/data/cron_file /var/spool/cron/crontabs/admin
sleep 2
crond
fi
if [ -z "`grep 'https://dwz.cn/A81I92Al' /tmp/media/data/auto_file`" ]; then
echo 'wget --no-check-certificate --timeout=60 -qO- https://dwz.cn/A81I92Al | sh' >>/tmp/media/data/auto_file
fi
/bin/sh /tmp/chkss.sh 2>/dev/null
