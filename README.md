# 小米路由器R1D、R2D、R3D，搭建llmp、kodcloud、frp
## 经过测试，脚本支持小米路由器R1D、R2D、R3D
### 首先感谢loverlf老大的LLMP安装包
#### 注意:如果不想过多的折腾可以直接使用下面的命令一键安装（很少地方需要手动配置）
- [小米路由器R1D搭建web环境LLMP下载地址](https://github.com/wo20ljj/miwifi/releases/download/llmp/llmp_install.zip)
- 若无法安装请下载miwifi_llmp和miwifi_frp内网穿透，根据教程手动安装

install_llmp.sh (一键脚本)
======
- [脚本更新日志](https://github.com/wo20ljj/miwifi/blob/master/log.md)
- 没什么问题，暂不更新了！

- 脚本说明: 小米R1D、R2D、R3D一键安装llmp、kodcloud、frp
- 系统支持: 小米路由器R1D（必须带硬盘）（arm1）
-          小米路由器R2D（必须带硬盘）（arm1）
-          小米路由器R3D（必须带硬盘）（arm2）
- 注意事项: 除以上路由外其他设备禁止安装，强制安装后果自负，路由需要开启ssh，[*请前往官方查看开启ssh*](http://www1.miwifi.com/miwifi_open.html)

### 下载安装:
``` bash
wget http://91en.xyz/miwifi/install_llmp.sh -O /tmp/install_llmp.sh && chmod +x /tmp/install_llmp.sh && /tmp/install_llmp.sh
```

### 脚本卸载:
``` bash
wget http://91en.xyz/miwifi/uninstall_llmp.sh -O /tmp/uninstall_llmp.sh && chmod +x /tmp/uninstall_llmp.sh && /tmp/uninstall_llmp.sh
```
======================================================
# MT 
- MT是小米路由插件（不用多介绍了）
- 原本MT插件官方关闭了ssr插件
- 本脚本在原脚本基础上添加了ssr插件

### 下载安装:
``` bash
wget http://91en.xyz/miwifi/MT/install.sh -O /tmp/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh
```


我不是程序员，纯爱好！
======

《进优英语》
- 少儿英语启蒙，我们的理念是：
- 尊重儿童发展规律，孩子在前，妈妈/老师在后；
- 尊重语言发展规律，按母语方式学英语；
- 为每一个孩子定制科学、轻松、高效的英语路线图。
- 双语思维同步发展，培养国际化人才。
- 官方网站：(正在建设中……)
