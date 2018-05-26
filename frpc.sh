#!/bin/sh
 
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
#  版本更新：更新启动脚本功能
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
    read -p  "请输入内网IP:默认[127.0.0.1]" Local
    if [ ! $Local ] ;then
        Local=127.0.0.1
	fi	
	read -p  "请输入网页端口:默认[80]" port
    if [ ! $port ] ;then
        port=80
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
server_port = 7000
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
(1) Linux_X86 
(2) Linux_X64
(3) ARM
(4) Mips
(5) Mips64 
(6) Mipsle
(7) Mips64le 
(8) 如果已经下载好了FRP客户端 
    请将下载好的文件保存到/root/frp下
    并重命名为frp.tar.gz
 
EOF
        read -p "请输入序号:" key
        case $key in
            1)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_386.tar.gz
            ;;
            2)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_amd64.tar.gz
            ;;
            3)  
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_arm.tar.gz
            ;;
            4)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_mips.tar.gz
            ;;
            5)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_mips64.tar.gz
            ;;
            6)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_mipsle.tar.gz
            ;;
            7)
                download http://91en.xyz/frp/v0.9.3/frp_0.9.3_linux_mips64le.tar.gz
            ;;
            8)
                echo "OK"
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
#  Linux_x86/64通过: \"service frp start\" 命令启动
#  Lnuxi_x86/64通过：\"chkconfig frp on\" 设置开机启动
#  其他架构通过：\"cd /root/frp/frp-config/ && nohup ./frpc -c ./frpc.ini &\" 命令启动
#  其他架构通过：\"vim /etc/rc.local\" 设置开机启动
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