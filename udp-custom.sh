#!/bin/bash

cd
rm -rf /root/udp
mkdir -p /root/udp

# change to time GMT+7
echo "change to time GMT+7"
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# install udp-custom
echo descargando udp-custom
wget https://raw.githubusercontent.com/Truxy33/udpniko/refs/heads/main/udp-custom-linux-amd64 -O /root/udp/udp-custom 
chmod +x /root/udp/udp-custom
# config json
echo descargando default config json
wget https://raw.githubusercontent.com/Truxy33/udpniko/refs/heads/main/config.json -O /root/udp/config.json
chmod 644 /root/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

echo cargando servicio udp-custom
systemctl start udp-custom &>/dev/null

echo activando servicio udp-custom
systemctl enable udp-custom &>/dev/null

echo reboot
reboot