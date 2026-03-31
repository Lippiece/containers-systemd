#!/bin/sh
set -e

gost -L "redir://:12345" -F "socks5://xray:2334" &

sleep 1

iptables -t nat -A OUTPUT -d 127.0.0.0/8 -j RETURN
iptables -t nat -A OUTPUT -d 10.88.0.0/16 -j RETURN
iptables -t nat -A OUTPUT -d $(getent hosts xray | awk '{print $1}') -j RETURN
iptables -t nat -A OUTPUT -d $(getent hosts synapse | awk '{print $1}') -j RETURN
iptables -t nat -A OUTPUT -d $(getent hosts mas | awk '{print $1}') -j RETURN
iptables -t nat -A OUTPUT -d 10.89.0.0/24 -j RETURN

iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to-ports 12345

chmod +x /docker-run.sh
exec /docker-run.sh
