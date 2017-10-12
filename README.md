# 小米路由器R1D、R2D，搭建LLMP、frp、kodexplorer
### 首先感谢loverlf老大的LLMP安装包
#### 注意:如果不想过多的折腾可以直接使用下面的命令一键安装（很少地方需要手动配置）
- [*小米路由器R1D、R2D搭建web环境LLMP下载地址*](https://github.com/wo20ljj/miwifi/releases/download/llmp_install/llmp_install.zip)
- 若无法安装请下载miwifi_llmp和miwifi_frp内网穿透，根据教程手动安装

install_llmp_frp.sh
======

- 脚本说明: 小米R1D、R2D一键安装llmp、frp、kodexplorer
- 系统支持: 小米路由器R1D、R2D（必须带硬盘）（cpu=arm）
- 注意事项: 除R1D、R2D外其他路由禁止安装，强制安装后果自负，路由需要开启ssh，[*请前往官方查看开启ssh*](http://www1.miwifi.com/miwifi_open.html)

### 下载安装:
``` bash
wget http://91en.xyz/miwifi/install_llmp_frp.sh -O /tmp/install_llmp_frp.sh && chmod +x /tmp/install_llmp_frp.sh && /tmp/install_llmp_frp.sh
```

1.0.1更新（2017-10-04）
- 1、修改部分下载目录和解压目录，统一到一个文件夹下，方便管理
- 2、修改安装完成后自动删除安装包

1.0.2更新（2017-10-06）
- 1、修复安装完成后frpc没有启动的问题
- 2、更改默认frp服务商站点

我不是程序员，纯爱好！
======

我是做少儿英语培训的，我们的理念是：
- 尊重儿童发展规律，孩子在前，妈妈/老师在后；
- 尊重语言发展规律，按母语方式学英语；
- 为每一个孩子定制科学、轻松、高效的英语路线图。
- 双语思维同步发展，培养国际化人才。
- 官方网站：http://www.91en.pw   (正在建设中...还未完善..敬请期待.)
