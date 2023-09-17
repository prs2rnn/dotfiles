#!/usr/bin/env bash
# sudo ./createClient.sh "10.66.0." "91.286.129.22:51820" 2 "mac"

umask 077

ipv4="$1$3"
serv4="0.0.0.0"
target="$2"
name="$4"

wg genkey | tee "keys/${name}.private" | wg pubkey > "keys/${name}.public"

echo "" >> /etc/wireguard/wg0.conf
echo "# ${name}" >> /etc/wireguard/wg0.conf
echo "[Peer]" >> /etc/wireguard/wg0.conf
echo "PublicKey = $(cat "keys/${name}.public")" >> /etc/wireguard/wg0.conf
echo "AllowedIPs = ${ipv4}/32" >> /etc/wireguard/wg0.conf

echo "[Interface]" > "files/${name}.conf"
echo "Address = ${ipv4}/32" >> "files/${name}.conf"
echo "DNS = $11" >> "files/${name}.conf" #Specifying DNS Server
echo "PrivateKey = $(cat "keys/${name}.private")" >> "files/${name}.conf"
echo "" >> "files/${name}.conf"
echo "[Peer]" >> "files/${name}.conf"
echo "PublicKey = $(cat keys/public.key)" >> "files/${name}.conf"
echo "Endpoint = $target" >> "files/${name}.conf"
echo "AllowedIPs = ${serv4}/0" >> "files/${name}.conf"
echo "PersistentKeepalive = 25" >> "files/${name}.conf"

# Print QR code scanable by the Wireguard mobile app on screen
qrencode -t ansiutf8 < "files/${name}.conf"

# wg syncconf wg0 <(wg-quick strip wg0)
chown www:www "files/${name}.conf"
chown www:www "keys/${name}.public"
chown www:www "keys/${name}.private"
