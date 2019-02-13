#!/bin/sh
#
# Copyright (C) 2018 autoget-v2ray
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
# This is free script, for help you auto synchronization local ip address and domain name.
echo 站点每十二小时更新一次端口、密码。
echo 更新时间为0:03、12:03
echo '脚本会自动在crontabs里添加 5 0,12 * * * /bin/sh /root/chkv2.sh 2>/dev/null'
echo 当然，能够获得此脚本，自然都是我很好的朋友。请不要将脚本外传
echo 使用的人一多，首先是速度会受影响。其次网站知名度高了之后，难保不被直接墙掉。
echo 此脚本完成于2019年大年初五，前后花费十五分钟。祝您春节愉快。您的朋友：达昆西
echo 按任意键开始或按ctrl+C中止运行
read -n 1
echo 开始运行，请等待至多2分钟
wget --no-check-certificate --timeout=60 -qO /root/chkv2.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2p_mtk_chkv2.sh
chmod 755 /root/chkv2.sh
echo 'download chkv2.sh commplete'
if [ -z "`grep '/root/chkv2.sh' /etc/crontabs/root`" ] ; then
echo '5 0,12 * * * /bin/sh /root/chkv2.sh' >>/etc/crontabs/root
fi
if [ -z "`grep '/root/chkv2.sh' /etc/rc.local`" ] ; then
sed -i 4i\ '/bin/sh /root/chkv2.sh' /etc/rc.local
fi
/bin/sh /root/chkv2.sh
