#!/bin/bash
iptables -D FORWARD -i eth0 -o tun0 -j ACCEPT
iptables -D FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
iptables -t mangle -D PREROUTING -i tun0 -j MARK --set-mark 1
ip route del default via $VPN_CLIENT_STATIC_IP dev eth0 table 100
ip rule del fwmark 1 table 100