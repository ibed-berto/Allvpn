#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
# ==================================================
# Link Hosting Kalian
ssh="raw.githubusercontent.com/ibed-berto/Allvpn/main/ssh"

# Link Hosting Kalian Untuk Xray
xray="raw.githubusercontent.com/ibed-berto/Allvpn/main/xray"

# Link Hosting Kalian Untuk Trojan Go
trojango="raw.githubusercontent.com/ibed-berto/Allvpn/main/trojango"

# Link Hosting Kalian Untuk Stunnel5
stunnel5="raw.githubusercontent.com/ibed-berto/Allvpn/main/stunnel5"

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=ID
state=Indonesia
locality=Indonesia
organization=rempaggrub
organizationalunit=rempaggrub
commonname=localhost
email=ibedberto@gmail.com

# simple password minimal
wget -O /etc/pam.d/common-password "https://${ssh}/password"
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

# install wget and curl
apt -y install wget curl
apt -y install net-tools

# Install Requirements Tools
apt install ruby -y
apt install python -y
apt install make -y
apt install cmake -y
apt install coreutils -y
apt install rsyslog -y
apt install net-tools -y
apt install zip -y
apt install unzip -y
apt install nano -y
apt install sed -y
apt install gnupg -y
apt install gnupg1 -y
apt install bc -y
apt install jq -y
apt install apt-transport-https -y
apt install build-essential -y
apt install dirmngr -y
apt install libxml-parser-perl -y
apt install neofetch -y
apt install git -y
apt install lsof -y
apt install libsqlite3-dev -y
apt install libz-dev -y
apt install gcc -y
apt install g++ -y
apt install libreadline-dev -y
apt install zlib1g-dev -y
apt install libssl-dev -y
apt install libssl1.0-dev -y
apt install dos2unix -y

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof
echo "clear" >> .profile
echo "neofetch" >> .profile

# install webserver
apt -y install nginx php php-fpm php-cli php-mysql libxml-parser-perl
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
curl https://${ssh}/nginx.conf > /etc/nginx/nginx.conf
curl https://${ssh}/vps.conf > /etc/nginx/conf.d/vps.conf
sed -i 's/listen = \/var\/run\/php-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.3/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
cd /home/vps/public_html
wget -O /home/vps/public_html/index.html "https://${ssh}/index.html1"
/etc/init.d/nginx restart
cd

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://${ssh}/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500


# setting port ssh
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 2253' /etc/ssh/sshd_config
echo "Port 22" >> /etc/ssh/sshd_config
echo "Port 42" >> /etc/ssh/sshd_config
/etc/init.d/ssh restart

# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 1153"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid (proxy nya aku matikan)
cd
#apt -y install squid3
#wget -O /etc/squid/squid.conf "https://${akbarvpn}/squid3.conf"
#sed -i $MYIP2 /etc/squid/squid.conf

# Install SSLH
apt -y install sslh
rm -f /etc/default/sslh

# Settings SSLH
cat > /etc/default/sslh <<-END
# Default options for sslh initscript
# sourced by /etc/init.d/sslh

# Disabled by default, to force yourself
# to read the configuration:
# - /usr/share/doc/sslh/README.Debian (quick start)
# - /usr/share/doc/sslh/README, at "Configuration" section
# - sslh(8) via "man sslh" for more configuration details.
# Once configuration ready, you *must* set RUN to yes here
# and try to start sslh (standalone mode only)

RUN=yes

# binary to use: forked (sslh) or single-thread (sslh-select) version
# systemd users: don't forget to modify /lib/systemd/system/sslh.service
DAEMON=/usr/sbin/sslh

DAEMON_OPTS="--user sslh --listen 0.0.0.0:443 --ssl 127.0.0.1:777 --ssh 127.0.0.1:109 --openvpn 127.0.0.1:1194 --http 127.0.0.1:80 --pidfile /var/run/sslh/sslh.pid -n"

END

# Restart Service SSLH
service sslh restart
systemctl restart sslh
/etc/init.d/sslh restart
/etc/init.d/sslh status
/etc/init.d/sslh restart

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

# install stunnel 5 
cd /root/
wget -q -O stunnel5.zip "https://${stunnel5}/stunnel5.zip"
unzip -o stunnel5.zip
cd /root/stunnel
chmod +x configure
./configure
make
make install
cd /root
rm -r -f stunnel
rm -f stunnel5.zip
mkdir -p /etc/stunnel5
chmod 644 /etc/stunnel5

# Download Config Stunnel5
cat > /etc/stunnel5/stunnel5.conf <<-END
cert = /etc/xray/xray.crt
key = /etc/xray/xray.key
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 445
connect = 127.0.0.1:109

[openssh]
accept = 777
connect = 127.0.0.1:443

[openvpn]
accept = 990
connect = 127.0.0.1:1194


END

# make a certificate
#openssl genrsa -out key.pem 2048
#openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
#-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
#cat key.pem cert.pem >> /etc/stunnel5/stunnel5.pem

# Service Stunnel5 systemctl restart stunnel5
cat > /etc/systemd/system/stunnel5.service << END
[Unit]
Description=Stunnel5 Service
Documentation=https://stunnel.org
Documentation=https://github.com/Akbar218
After=syslog.target network-online.target

[Service]
ExecStart=/usr/local/bin/stunnel5 /etc/stunnel5/stunnel5.conf
Type=forking

[Install]
WantedBy=multi-user.target
END

# Service Stunnel5 /etc/init.d/stunnel5
wget -q -O /etc/init.d/stunnel5 "https://${stunnel5}/stunnel5.init"

# Ubah Izin Akses
chmod 600 /etc/stunnel5/stunnel5.pem
chmod +x /etc/init.d/stunnel5
cp /usr/local/bin/stunnel /usr/local/bin/stunnel5

# Remove File
rm -r -f /usr/local/share/doc/stunnel/
rm -r -f /usr/local/etc/stunnel/
rm -f /usr/local/bin/stunnel
rm -f /usr/local/bin/stunnel3
rm -f /usr/local/bin/stunnel4
#rm -f /usr/local/bin/stunnel5

# Restart Stunnel 5
systemctl stop stunnel5
systemctl enable stunnel5
systemctl start stunnel5
systemctl restart stunnel5
/etc/init.d/stunnel5 restart
/etc/init.d/stunnel5 status
/etc/init.d/stunnel5 restart

#OpenVPN
wget https://${ssh}/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear

# banner /etc/issue.net
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# Install BBR
#wget https://${akbarvpn}/bbr.sh && chmod +x bbr.sh && ./bbr.sh

# Ganti Banner
wget -O /etc/issue.net "https://${ssh}/issue.net"

# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# download script
cd /usr/bin
wget -O addhost "https://${ssh}/addhost.sh"
wget -O slhost "https://${ssh}/slhost.sh"
wget -O about "https://${ssh}/about.sh"
wget -O menu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/menu.sh"
wget -O addssh "https://${ssh}/addssh.sh"
wget -O trialssh "https://${ssh}/trialssh.sh"
wget -O delssh "https://${ssh}/delssh.sh"
wget -O member "https://${ssh}/member.sh"
wget -O delexp "https://${ssh}/delexp.sh"
wget -O cekssh "https://${ssh}/cekssh.sh"
wget -O restart "https://${ssh}/restart.sh"
wget -O speedtest "https://${ssh}/speedtest_cli.py"
wget -O info "https://${ssh}/info.sh"
wget -O ram "https://${ssh}/ram.sh"
wget -O renewssh "https://${ssh}/renewssh.sh"
wget -O autokill "https://${ssh}/autokill.sh"
wget -O ceklimit "https://${ssh}/ceklimit.sh"
wget -O tendang "https://${ssh}/tendang.sh"
wget -O clearlog "https://${ssh}/clearlog.sh"
wget -O changeport "https://${ssh}/changeport.sh"
wget -O portovpn "https://${ssh}/portovpn.sh"
wget -O portwg "https://${ssh}/portwg.sh"
wget -O porttrojan "https://${ssh}/porttrojan.sh"
wget -O portsstp "https://${ssh}/portsstp.sh"
wget -O portsquid "https://${ssh}/portsquid.sh"
wget -O portvlm "https://${ssh}/portvlm.sh"
wget -O wbmn "https://${ssh}/webmin.sh"
wget -O xp "https://${ssh}/xp.sh"
wget -O swapkvm "https://${ssh}/swapkvm.sh"
wget -O addvmess "https://${xray}/addv2ray.sh"
wget -O addvless "https://${xray}/addvless.sh"
wget -O addtrojan "https://${xray}/addtrojan.sh"
wget -O addgrpc "https://${xray}/addgrpc.sh"
wget -O cekgrpc "https://${xray}/cekgrpc.sh"
wget -O delgrpc "https://${xray}/delgrpc.sh"
wget -O renewgrpc "https://${xray}/renewgrpc.sh"
wget -O delvmess "https://${xray}/delv2ray.sh"
wget -O delvless "https://${xray}/delvless.sh"
wget -O deltrojan "https://${xray}/deltrojan.sh"
wget -O cekvmess "https://${xray}/cekv2ray.sh"
wget -O cekvless "https://${xray}/cekvless.sh"
wget -O cektrojan "https://${xray}/cektrojan.sh"
wget -O renewvmess "https://${xray}/renewv2ray.sh"
wget -O renewvless "https://${xray}/renewvless.sh"
wget -O renewtrojan "https://${xray}/renewtrojan.sh"
wget -O certv2ray "https://${xray}/certv2ray.sh"
wget -O addtrgo "https://${trojango}/addtrgo.sh"
wget -O deltrgo "https://${trojango}/deltrgo.sh"
wget -O renewtrgo "https://${trojango}/renewtrgo.sh"
wget -O cektrgo "https://${trojango}/cektrgo.sh"
wget -O portsshnontls "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/websocket/portsshnontls.sh"
wget -O portsshws "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/websocket/portsshws.sh"

wget -O ipsaya "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/ipsaya.sh"
wget -O sshovpnmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/sshovpn.sh"
wget -O l2tpmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/l2tpmenu.sh"
wget -O pptpmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/pptpmenu.sh"
wget -O sstpmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/sstpmenu.sh"
wget -O wgmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/wgmenu.sh"
wget -O ssmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/ssmenu.sh"
wget -O ssrmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/ssrmenu.sh"
wget -O vmessmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/vmessmenu.sh"
wget -O vlessmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/vlessmenu.sh"
wget -O grpcmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/grpcmenu.sh"
wget -O grpcupdate "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/grpcupdate.sh"
wget -O trmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/trmenu.sh"
wget -O trgomenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/trgomenu.sh"
wget -O setmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/setmenu.sh"
wget -O slowdnsmenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/slowdnsmenu.sh"
wget -O running "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/running.sh"
wget -O updatemenu "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/update/updatemenu.sh"
wget -O sl-fix "https://raw.githubusercontent.com/ibed-berto/Allvpn/main/sslh-fix/sl-fix"

#ubah izin acces
chmod +x sl-fix
chmod +x ipsaya
chmod +x sshovpnmenu
chmod +x l2tpmenu
chmod +x pptpmenu
chmod +x sstpmenu
chmod +x wgmenu
chmod +x ssmenu
chmod +x ssrmenu
chmod +x vmessmenu
chmod +x vlessmenu
chmod +x grpcmenu
chmod +x grpcupdate
chmod +x trmenu
chmod +x trgomenu
chmod +x setmenu
chmod +x slowdnsmenu
chmod +x running
chmod +x updatemenu


chmod +x portsshnontls
chmod +x portsshws

chmod +x slhost
chmod +x addhost
chmod +x menu
chmod +x addssh
chmod +x trialssh
chmod +x delssh
chmod +x member
chmod +x delexp
chmod +x cekssh
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklimit
chmod +x ram
chmod +x renewssh
chmod +x clearlog
chmod +x changeport
chmod +x portovpn
chmod +x portwg
chmod +x porttrojan
chmod +x portsstp
chmod +x portsquid
chmod +x portvlm
chmod +x wbmn
chmod +x xp
chmod +x swapkvm
chmod +x addvmess
chmod +x addvless
chmod +x addtrojan
chmod +x addgrpc
chmod +x delgrpc
chmod +x delvmess
chmod +x delvless
chmod +x deltrojan
chmod +x cekgrpc
chmod +x cekvmess
chmod +x cekvless
chmod +x cektrojan
chmod +x renewgrpc
chmod +x renewvmess
chmod +x renewvless
chmod +x renewtrojan
chmod +x certv2ray
chmod +x addtrgo
chmod +x deltrgo
chmod +x renewtrgo
chmod +x cektrgo

#auto reboot
echo "0 5 * * * root clearlog && reboot" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
echo "0 1 * * * root delexp" >> /etc/crontab
echo "10 4 * * * root clearlog && sslh-fix-reboot" >> /etc/crontab
echo "0 0 * * * root clearlog && reboot" >> /etc/crontab
echo "0 12 * * * root clearlog && reboot" >> /etc/crontab
echo "0 18 * * * root clearlog && reboot" >> /etc/crontab


# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/vnstat restart
/etc/init.d/fail2ban restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh

# finihsing
clear
