#!/bin/sh
#
# Copyright (C) 2018 autoget-SS
# Copyright (C) 2018 child9527 <child9527@qq.com>
#
wget --no-check-certificate --timeout=60 -qO /root/chkss.sh https://raw.githubusercontent.com/child9527/getvpn/master/k2p_brc_chkss.sh
chmod 777 /root/chkss.sh
/bin/sh /root/chkss.sh 2>/dev/null
sed -i 1i\ '17 */3 * * * /bin/sh /root/chkss.sh 2>/dev/null' /tmp/media/data/cron_file
sed -i 1i\ '/bin/sh /root/chkv2.sh 2>/dev/null' /tmp/media/data/auto_file
