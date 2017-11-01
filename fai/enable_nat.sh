#!/bin/bash

# Basic firewall for NAT
# You MUST enable nat if your fai server is the main dhcp server of your network

iface="myethS8"

iptables -F
iptables -F INPUT
iptables -F OUTPUT
iptables -F POSTROUTING -t nat
iptables -F PREROUTING -t nat

modprobe iptable_nat
iptables -t nat -A POSTROUTING -o $iface -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
