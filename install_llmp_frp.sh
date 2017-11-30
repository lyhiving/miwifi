#!/bin/sh

echo -e "#======================================================================
#  安装前请确认您的路由器为小米路由器一代硬盘版（R1D）
#  除R1D外其他路由暂不支持，强制安装后果自负
#  Description: llmp+frp+kodexplorer一键安装
#  Version: 1.0.6
#  Author: David
#  web: http://91en.xyz/miwifi
#======================================================================"

echo "您确认要安装吗？请输入y继续/n退出"
read
[ "$REPLY" = "y" -o "$REPLY" = "Y" ] || { echo "退出安装..."; exit; }

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> 正在安装llmp请稍后 >>>>>>>>>>>>>>>>>>>>>>>>>>"
wget -c -t 0 http://91en.xyz/miwifi/llmp_install.bin -O /tmp/llmp_install.bin
chmod +x /tmp/llmp_install.bin && /tmp/llmp_install.bin in
cd /userdisk/llmp/manager/ && ./start_llmp.sh

rm -rf /tmp/llmp_install.zip
rm -rf /tmp/llmp_install.bin

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> 正在安装kodexplorer >>>>>>>>>>>>>>>>>>>>>>>>>>"
cd /tmp
curl -C - -o kodexplorer.zip https://codeload.github.com/kalcaddle/KodExplorer/zip/master
chmod +x /tmp/kodexplorer.zip
unzip /tmp/kodexplorer.zip -d /userdisk/data/wwwroot
cp -r /userdisk/data/wwwroot/KodExplorer-master/. /userdisk/data/wwwroot
chmod -R +x /userdisk/data/wwwroot
chmod 777 /userdisk/data/wwwroot/index.php

rm -rf /tmp/kodexplorer.zip
rm -rf /userdisk/data/wwwroot/KodExplorer-master

chmod +x /etc/rc.local
wget http://91en.xyz/miwifi/rc.local -O /etc/rc.local

echo -e "\033[32m #======================================================================
#  到此已安装成功,安装结束后重启路由，本地可用“ip:8080”访问站点
#  已添加服务随路由自动启动
#  如安装失败请手动下载安装，工具和教程都在下面提供的链接里
#  请复制下载地址：https://pan.baidu.com/s/1pLV07xT  密码:ndwu
#  或访问Github:https://github.com/wo20ljj/miwifi
#====================================================================== \033[0m \n"

echo -e "\033[35m 如您的网络是大内网请输入y继续安装frp内网穿透，如果是公网ip则跳过直接输入n退出安装 \033[0m \n"
sleep 2s
echo -e "\033[35m 安装frp内网穿透客户端！请输入y继续/n退出 \033[0m \n"
read
[ "$REPLY" = "y" -o "$REPLY" = "Y" ] || { echo "退出安装..."; exit; }

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> 正在安装frp请稍候 >>>>>>>>>>>>>>>>>>>>>>>>>>"
wget -c -t 0 http://91en.xyz/miwifi/frp_0.9.3_linux_arm.tar.gz -O /tmp/frp_0.9.3_linux_arm.tar.gz
chmod +x /tmp/frp_0.9.3_linux_arm.tar.gz
tar -zxvf /tmp/frp_0.9.3_linux_arm.tar.gz -C /userdisk
cd /userdisk
mv frp_0.9.3_linux_arm frpc

echo -e "\033[33m #============================配置frpc.ini==============================
#  1、请手动配置frpc.ini
#  2、将local_ip = 192.168.xx.x改为自己的IP
#  3、将custom_domains = xxx.xx.xx改为已经解析的域名
#  4、默认端口为local_port = 8080可不用更改
#  5、按i键进入修改，完成后按Esc键，再输入:wq回车保存
#  6、这里提供2个免费frp服务商，默认为frp1.chuantou.org
#  ( server_addr = frp1.chuantou.org  |  privilege_token = www.xxorg.comor )
#  ( server_addr = frp.lu8.win        |  privilege_token = frp888          )
#========================配置过程可随时向上翻阅======================== \033[0m \n"
echo -e "\033[35m 请认真阅读以上内容，如配置错误将无法启动服务！请输入y继续 \033[0m \n"
read
[ "$REPLY" = "y" -o "$REPLY" = "Y" ]

wget http://91en.xyz/miwifi/frpc.ini -O /userdisk/frpc/frpc.ini
vi /userdisk/frpc/frpc.ini
cd /userdisk/frpc/ && nohup ./frpc -c ./frpc.ini

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> frpc.ini配置完成 >>>>>>>>>>>>>>>>>>>>>>>>>>"

sleep 1s

echo -e "\033[32m #======================================================================
#  安装成功,如成功配置frp，可用“域名”或“ip:8080”访问站点
#  无法访问请检查frpc.ini的配置
#  安装过程服务器压力较大，速度有限，请耐心等待
#  如无法自动下载安装请手动下载，工具和教程都在下面提供的链接里
#  请复制下载地址：https://pan.baidu.com/s/1pLV07xT  密码:ndwu
#  或访问Github:https://github.com/wo20ljj/miwifi
#====================================================================== \033[0m \n"

rm -rf /tmp/frp_0.9.3_linux_arm.tar.gz
rm -rf /tmp/install_llmp_frp.sh

