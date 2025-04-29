#!/bin/bash
ip rule add fwmark 1 table 100
ip route add default via $VPN_CLIENT_STATIC_IP dev eth0 table 100
iptables -t mangle -A PREROUTING -i tun0 -j MARK --set-mark 1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT