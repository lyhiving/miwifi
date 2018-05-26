#!/bin/sh

echo -e "
#======================================================================
#  安装前请确认您的路由器为小米路由器硬盘版（R1D,R2D,R3D）
#  除R1D,R2D,R3D外其他路由暂不支持，强制安装后果自负
#  Description: llmp+kodcloud+frp一键安装
#  Version: 1.0.7
#  Author: David
#  web: http://91en.xyz/miwifi
#======================================================================
#  1.0.7更新：修改frp客户端安装模式，更方便配置
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

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> 正在安装kodcloud >>>>>>>>>>>>>>>>>>>>>>>>>>"
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

echo -e "\033[32m 
#======================================================================
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
 
green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal
#set temp step
rand1=$RANDOM 
rand2=$RANDOM
clear
 
download(){
    echo -n "下载FRP . . ."
    sleep 1 
    echo -n "."
    mkdir /root/frp
    wget -O /root/frp/frp.tar.gz $1
    if [ $? == 0 ] ; then
        echo -e "[${green}成功${nc}]"
    else
        echo -e "[${red}失败${nc}]"
        exit 1
    fi
}
 
install(){
    echo -n "Installing Frp . . ."
    pcd=`pwd`
    cd /root/frp/
    sleep 1
    echo -n "."
    tar zxf /root/frp/frp.tar.gz 
    if [ $? == 0 ] ; then
        echo -e "[${green}成功${nc}]"
    else
        echo -e "[${red}失败${nc}]"
        exit 1
    fi
    rm -f /root/frp/frp.tar.gz
    mv frp_0.* frp-config
    cd $pcd
}
 
cat << EOF
#=========================================================================
#
#  欢迎使用FRP内网映射脚本
#
#=========================================================================
#
#  注意：此脚本的frp客户端版本：0.9.3 
#  
#  frp服务端域名和密码可使用默认的免费服务
#
#=========================================================================

你确定要安装吗?
EOF
config(){
    echo -n "设置FRP Frp . . ."
    pcd=`pwd`
    cd /root/frp/frp-config
    sleep 1
    echo -n "."
    rm -f frpc.ini
    touch frpc.ini
    read -p  "请输入FRP服务端域名:默认为免费服务[frp1.chuantou.org]" IP
    if [ ! $IP ] ;then
        IP=frp1.chuantou.org
    fi	
    read -p  "请输入FRP服务端密码:默认为免费服务[www.xxorg.com]" password
    if [ ! $password ] ;then
        password=www.xxorg.com
    fi
	read -p  "请输入FRP服务端端口:默认为免费服务[7000]" sport
    if [ ! $sport ] ;then
        sport=7000
    fi
    read -p  "请输入内网IP:默认[192.168.31.1]" Local
    if [ ! $Local ] ;then
        Local=192.168.31.1
	fi	
	read -p  "请输入网页端口:默认[8080]" port
    if [ ! $port ] ;then
        port=8080
    fi
    read -p  "请输入自己网站已解析的域名:[www.youname.com]" Domain
    if [ ! $Domain ] ;then
        Domain=www.youname.com
    fi 
    read -p  "请设置HTTP端口隧道名称（名称随意）:[$rand1]" HTTP
    if [ ! $HTTP ] ;then
        HTTP=$rand1
    fi
    read -p  "请设置SSH端口隧道名称(名称随意):[$rand2]" SSH
    if [ ! $SSH ] ;then
        SSH=$rand2
    fi
     
cat > frpc.ini <<EOF
[common]
server_addr = $IP
server_port = $sport
log_file = ./frpc.log
log_level = info
log_max_days = 3
privilege_token = $password
 
[$HTTP]
privilege_mode = true
type = http
local_ip = $Local
local_port = $port
custom_domains = $Domain
 
[$SSH]
privilege_mode = true
type = tcp
remote_port = $rand2
local_ip = $Local
local_port = 22
use_gzip = true use_encrypti
EOF
 
sudo cat > /etc/init.d/frp <<EOF
#!/bin/sh
# chkconfig: - 99 2
# description: FRP Client Control Script
PIDF=\` ps  -A | grep frpc | awk '{print \$1}'\`
case "\$1" in
        start)
        nohup /root/frp/frp-config/frpc -c /root/frp/frp-config/frpc.ini >/dev/null 2>&1  &
        ;;
        stop)
        kill -3  \$PIDF
        ;;
        restart)
        \$0 stop &> /dev/null
        if [ \$? -ne 0 ] ; then continue ; fi
        \$0 start
        ;;
        reload)
        kill -1 \$PIDF
        ;;
    status)
    cat /frpc.log
    ;;
        *)
        echo "Userage: \$0 { start | stop | restart | reload | status }"
        exit 1
esac
exit 0
 
EOF
 
 
chmod +x /etc/init.d/frp
 
    if [ $? == 0 ] ; then
        echo -e "[${green}成功${nc}]"
    else
        echo -e "[${red}失败${nc}]"
        exit 1
    fi
    cd $pcd
}
 
 
 
read -p "请输入[Y/y]确定安装[N/n]退出安装" key
case $key in
    "y"|"Y"|"")     
        cat << EOF
请输入你的Linux系统类型:
(1) ARM
(2) Mips
(3) Mips64 
(4) Mipsle
(5) Mips64le 
 
EOF
        read -p "请输入序号:" key
        case $key in
            1)  
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_arm.tar.gz
            ;;
            2)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_mips.tar.gz
            ;;
            3)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_mips64.tar.gz
            ;;
            4)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_mipsle.tar.gz
            ;;
            5)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_mips64le.tar.gz
            ;;
            *)
                exit
            ;;
            esac
            install
            config
            result=$?
            echo -n "FRP客户端安装结果  .."
            if [ $result == 0 ] ; then
                echo -e "[${green}成功${nc}]"
                echo "Enjoy~"
                sleep 1
echo -e "\033[32m 
#=========================================================================
#  通过：\"cd /root/frp/frp-config/ && nohup ./frpc -c ./frpc.ini &\" 命令启动
#  通过：\"vim /etc/rc.local\" 设置开机启动
#  配置文件路径 /root/frp/frp-config/frpc.ini
#  最后请将网站域名解析到frp服务端域名
#========================================================================= \033[0m \n"
                sleep 1
                exit
            else
                echo -e "[${red}失败${nc}]"
                exit 1
            fi
    ;;
    *)
    exit
    ;;
esac
cd /userdisk/frpc/ && nohup ./frpc -c ./frpc.ini &

echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>> frpc.ini配置完成 >>>>>>>>>>>>>>>>>>>>>>>>>>"

sleep 1s

echo -e "\033[32m #======================================================================
#  安装成功,如成功配置frp，可用“域名”或“ip:8080”访问站点
#  域名无法访问请检查是否解析，frpc.ini是否配置准确
#  安装过程服务器压力较大，速度有限，请耐心等待
#  如无法自动下载安装请手动下载，工具和教程都在下面提供的链接里
#  请复制下载地址：https://pan.baidu.com/s/1pLV07xT  密码:ndwu
#  或访问Github:https://github.com/wo20ljj/miwifi
#====================================================================== \033[0m \n"

rm -rf /tmp/install_llmp.sh

