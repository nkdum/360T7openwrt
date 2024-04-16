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
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='ImmortalWrt'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='JayKwok $(date +"%y%m%d")'/g" package/base-files/files/etc/openwrt_release
cp -af feeds/extraipk/patch/diy/banner  package/base-files/files/etc/banner
echo "DISTRIB_MODEL='360T7'" >> package/base-files/files/etc/openwrt_release
target=$(grep -m 1 "CONFIG_TARGET_.*_.*=y" .config | sed "s/CONFIG_TARGET_\(.*\)_\(.*\)=y/\1\/\2/g")
for configFile in $(ls target/linux/$target/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done
