#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i 's#<%=luci.sys.exec("cat /etc/bench.log") or " "%>##' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i "/luci.model.network/a local wifi_infs = \"ra0 rai0\"" iface.htm
sed -i '/"_custom")/a attr("checked", "checked") ..' iface.htm
sed -i 's#attr("value", " ")#attr("value", wifi_infs)#' iface.htm
sed -i "s/_custom').checked=true/_custom').checked=true\" value=\"<%=wifi_infs%>/" iface.htm
sed -i '/ppp-mod-pppoe/,/ddns-scripts_dnspod/{//!d;};' include/target.mk
sed -i '/ddns-scripts_dnspod/d' include/target.mk
sed -i '/ppp-mod-pppoe/a luci-newapi kmod-nf-nathelper kmod-nf-nathelper-extra kmod-ipt-raw luci luci-app-wol curl' include/target.mk
sed -i 's/START=95/START=15/g' package/base-files/files/etc/init.d/done
