# openwrt-action
##主要功能
* workflow: redpill.yml - 生成 dsm7.0 loader，包含vmxnet3驱动
* rm2100: 编译最新lean的openwrt for RedmiAc2100 (精简版)
* Dockerfile 生成m1下docker build openwrt的镜像 (感谢 https://github.com/mwarning/docker-openwrt-builder)
```bash
#初始运行一次，创建大小写敏感磁盘
hdiutil create -size 20g -type SPARSE -fs "Case-sensitive HFS+" -volname OpenWrt OpenWrt.sparseimage
hdiutil attach OpenWrt.sparseimage

docker build -t openwrt_builder .

docker run --name openwrt -p 20022:22 -dt -v /Volumes/Openwrt/lede:/home/openwrt/lede openwrt_builder
```