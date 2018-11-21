# 小米路由器R1D、R2D、R3D，搭建llmp、kodcloud、frp

- 若无法安装请下载miwifi_llmp和miwifi_frp内网穿透，根据教程手动安装

install_llmp.sh (一键脚本)
======
- [脚本更新日志](https://github.com/wo20ljj/miwifi/blob/master/log.md)
- 没什么问题，暂不更新了！（最近一次更新2018-06-24 version：1.0.8）

- 脚本说明: 小米R1D、R2D、R3D一键安装llmp、kodcloud、frp
- 系统支持:   
  小米路由器R1D（必须带硬盘）（arm1）  
  小米路由器R2D（必须带硬盘）（arm1）  
  小米路由器R3D（必须带硬盘）（arm2）  
- 注意事项: 除以上路由外其他设备禁止安装，强制安装后果自负，路由需要开启ssh，[*请前往官方查看开启ssh*](http://www1.miwifi.com/miwifi_open.html)

### 下载安装:
``` bash
wget http://d.tedx.net/miwifi/install_llmp.sh -O /tmp/install_llmp.sh && chmod +x /tmp/install_llmp.sh && /tmp/install_llmp.sh
```

### 脚本卸载:
``` bash
wget http://d.tedx.net/miwifi/uninstall_llmp.sh -O /tmp/uninstall_llmp.sh && chmod +x /tmp/uninstall_llmp.sh && /tmp/uninstall_llmp.sh
```
======================================================
# MT 简单版
- MT是小米路由插件（不用多介绍了）
- 原本MT插件官方关闭了ssr插件
- 本脚本在原脚本基础上添加了ssr插件

### 下载安装:
``` bash
rm -rf /tmp/install.sh && wget http://d.tedx.net/miwifi/MT/install.sh -O /tmp/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh
```

# MT2.0 分流版本
- MT2.0官方已经不提供
- 全部封装原来的内容

### 一键安装:
``` bash
rm -rf /tmp/install.sh && wget http://d.tedx.net/miwifi/MT/tools/appstore/install.sh -O /tmp/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh
```
