#!/bin/bash
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT