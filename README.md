# 小米路由器R1D、R2D，搭建LLMP、frp、kodexplorer
- [*小米路由器R1D、R2D搭建web环境LLMP下载地址*](https://github.com/wo20ljj/miwifi/releases/download/llmp_install/llmp_install.zip)
- 脚本如果安装失败或安装成功后完全没用，说明并没有安装成功
- 原因是91en.xyz站点无法访问，脚本没有下载成功导致（站点为家用PC搭建随时有可能关闭）
- 若91en.xyz关闭，可[*在此页面下载*](https://github.com/wo20ljj/miwifi/)一键脚本
- 下载之后用winscp等工具将文件放到小米路由硬盘下tmp文件中
- 用ssh工具执行chmod +x /tmp/install_llmp_frp.sh && /tmp/install_llmp_frp.sh

install_llmp_frp.sh
======

- 脚本说明: 小米R1D、R2D一键安装llmp、frp、kodexplorer
- 系统支持: 小米路由器R1D、R2D（带硬盘）（cpu=arm）
- 注意事项: 除R1D、R2D外其他路由禁止安装，强制安装后果自负

### 下载安装:
``` bash
wget http://91en.xyz/miwifi/install_llmp_frp.sh -O /tmp/install_llmp_frp.sh
chmod +x /tmp/install_llmp_frp.sh && /tmp/install_llmp_frp.sh
```

我不是程序员，纯爱好！
======

我是做少儿英语培训的，我们的理念是：
- 尊重儿童发展规律，孩子在前，妈妈/老师在后；
- 尊重语言发展规律，按母语方式学英语；
- 为每一个孩子定制科学、轻松、高效的英语路线图。
- 双语思维同步发展，培养国际化人才。
- 官方网站：http://www.91en.pw   (正在建设中...还未完善..敬请期待.)
