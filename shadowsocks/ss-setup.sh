#!/bin/bash
# usage: sudo ./ss-setup.sh [v2ray]

export PORT=9544
export PASSWORD=$( cat /dev/urandom | tr --delete --complement 'a-z0-9' | head --bytes=16 )
export IP=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')
export ENCRYPTION=chacha20-ietf-poly1305
export V2RAY=$1

Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Off='\033[0m'       # Text Reset


function config() {
cat > "$1" <<EOF
{
    "server":"0.0.0.0",
    "server_port":$2,
    "mode": "tcp_and_udp",
    "local_port":1080,
    "password":"$3",
    "timeout":300,
    "method":"$ENCRYPTION"
}
EOF
}
function config_v2ray() {
cat > "$1" <<EOF
{
    "server":"0.0.0.0",
    "server_port":$2,
    "local_port":1080,
    "mode": "tcp_and_udp",
    "password":"$3",
    "plugin":"/etc/shadowsocks-libev/v2ray-plugin",
    "timeout":3000,
    "method":"$ENCRYPTION",
    "nameserver": "1.1.1.1",
    "no_delay": true,
    "fast_open": true,
    "reuse_port": true,
    "plugin_opts": "server"
}
EOF
}

function generate_hash() {
  echo -n "$1":"$2" | base64
}

function config_info() {
  echo
  echo -e "${Yellow}---------------------------------------${Off}"
  echo
  echo -e "${Green}shadowsocks proxy configuration:${Off}"
  echo -e "${Yellow}URL:${Off} ss://$(generate_hash chacha20-ietf-poly1305 $PASSWORD)@$IP:$PORT"
  echo
  echo -e "${Yellow}IP      :${Off} $IP "
  echo -e "${Yellow}Port    :${Off} $PORT "
  echo -e "${Yellow}Password:${Off} $PASSWORD "
  echo -e "${Yellow}---------------------------------------${Off}"
}
if [ -f "/etc/debian_version" ]; then
  DEBIAN_FRONTEND=noninteractive apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y shadowsocks-libev # install shadowsocks
  ufw allow "$PORT"/tcp
  ufw allow "$PORT"/udp
else
  echo "your os not supported"
fi

mkdir -p /etc/shadowsocks-libev # ceate config directory
if [ "$V2RAY" == "v2ray" ]; then
  wget https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.2/v2ray-plugin-linux-amd64-v1.3.2.tar.gz
  tar -xf v2ray-plugin-linux-amd64-v1.3.2.tar.gz
  rm v2ray-plugin-linux-amd64-v1.3.2.tar.gz
  mv v2ray-plugin_linux_amd64 /etc/shadowsocks-libev/v2ray-plugin
  chmod +x  /etc/shadowsocks-libev/v2ray-plugin
  setcap 'cap_net_bind_service=+ep' /etc/shadowsocks-libev/v2ray-plugin
  setcap 'cap_net_bind_service=+ep' /usr/bin/ss-server
  config_v2ray /etc/shadowsocks-libev/config.json "$PORT" "$PASSWORD"

elif [ -z "$V2RAY" ]; then
  config /etc/shadowsocks-libev/config.json "$PORT" "$PASSWORD"
else
echo -e  "${Red}v2ray plugin installed${Off}"
fi
systemctl enable shadowsocks-libev
systemctl restart shadowsocks-libev
config_info "$PORT" "$PASSWORD"
