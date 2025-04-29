#!/bin/bash
iptables -D FORWARD -i eth0 -o tun0 -j ACCEPT
iptables -D FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE