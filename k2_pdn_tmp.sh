#!/bin/sh
echo 站点每三个小时更新一次端口、密码，每天八次。
echo '更新时间为0:15、3:15…………19:15、21:15'
echo '脚本会自动在crontabs里添加 17 */3 * * * /bin/sh /tmp/chkss.sh 2>/dev/null'
echo 当然，能够获得此脚本，自然都是我很好的朋友。请不要将脚本外传
echo 使用的人一多，首先是速度会受影响。其次网站知名度高了之后，难保不被直接墙掉。
echo 此脚本完成于2019年大年初五，前后花费十五分钟。祝您春节愉快。您的朋友：达昆西
echo 按任意键开始或按ctrl+C中止运行
read -n 1
echo 开始运行，请等待至多2分钟
wget --no-check-certificate --timeout=60 -qO /etc/storage/chkss.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2_pdn_chkss.sh
chmod 777 /etc/storage/chkss.sh
if [ -z "`grep '/etc/storage/chkss.sh' /etc/storage/cron/crontabs/admin`" ]; then
sed -i 1a\ '17,20 */3 * * * /bin/sh /etc/storage/chkss.sh 2>/dev/null' /etc/storage/cron/crontabs/admin
fi
if [ -z "`grep '/etc/storage/chkss.sh' /etc/storage/post_wan_script.sh`" ]; then
echo '/bin/sh /etc/storage/chkss.sh 2>/dev/null' >>/etc/storage/post_wan_script.sh
fi
/bin/sh /etc/storage/chkss.sh
