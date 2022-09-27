#!/bin/bash


## Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi



echo "Script for Ubuntu-20.04 to install Shadowsocks-libev"
echo "Installing Shadowsocks through Snap"
snap install shadowsocks-libev
echo "shadowsocks-libev finish installing"
sleep 1

## Config directory
echo "[Making a directory for config files]"
mkdir -p /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev
sleep 1


## Config file
touch /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json
echo " ################################################################### "
echo " ################################################################### "
sleep 1 

echo "[Generating JSON config file]"
file="/var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json"
echo "{" > $file
echo "    \"server\":[\"[::0]\", \"0.0.0.0\"]," >> $file
echo "    \"mode\":\"tcp_and_udp\"," >> $file
echo "    \"server_port\":443," >> $file
echo "    \"password\":\"PASSWORD\"," >> $file
echo "    \"timeout\":60," >> $file
echo "    \"method\":\"chacha20-ietf-poly1305\"," >> $file
echo "    \"nameserver\":\"1.1.1.1\"" >> $file
echo "}" >> $file

echo "[Config file finished generating]" 

sleep 1

##systemd for shadowsocks-libev

echo "[Creating a systemd file]"
echo "This will make shadowsocks start automatically everytime"
touch /etc/systemd/system/shadowsocks-libev-server@.service
sleep 1 

##Service file

echo "[Unit]
Description=Shadowsocks-Libev Custom Server Service for %I
Documentation=man:ss-server(1)
After=network-online.target
Wants=network-online.target
    
[Service]
Type=simple
ExecStart=/usr/bin/snap run shadowsocks-libev.ss-server -c /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/%i.json
    
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/shadowsocks-libev-server@.service 

sleep 1

cat /etc/systemd/system/shadowsocks-libev-server@.service

sleep 1

echo "[Service file created]"
sleep 1

systemctl enable --now shadowsocks-libev-server@config 
echo "[shadowsocks service enabled]"
sleep 1

systemctl start shadowsocks-libev-server@config
echo "[shadowsocks service started]"
sleep 1


echo "[Optimzing server]"
file2="/etc/security/limits.conf"
echo "*soft nofile 51200" >> $file2
echo "*hard nofile 51200" >> $file2
echo "root soft nofile 51200" >> $file2
echo "root hard nofile 51200" >> $file2

sleep 1

echo "[Tuning kernel parameters]"
echo "fs.file-max = 51200
net.core.netdev_max_backlog = 250000
net.core.somaxconn = 4096
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 10000 65000
net.core.netdev_max_backlog = 4096
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.ipv4.tcp_mem = 25600 51200 102400
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864

net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sleep 1

echo "[Activating new settings]"
sysctl -p 
sleep 1

systemctl restart shadowsocks-libev-server@config
sleep 1

YOUR_SERVER_IP=$(hostname -I | awk '{ print $1}')


echo "Your shadowsocks server is ready"
echo "Connect with a shadowsocks client with the information below"
echo "
###############################################
###############################################
||Server            : $YOUR_SERVER_IP        ||      
||Port              : 443                    ||
||Password          : PASSWORD               ||
||Encryption method : chacha20-ietf-poly1305 ||
###############################################
###############################################
"

echo "To change the default password edit the config file with the command below."
echo "-> nano /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json"
echo "reboot the server after for it to take effect -> reboot "












