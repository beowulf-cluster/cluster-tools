#!/bin/bash

# Basic firewall for NAT

iface="myethS8"


# Your front-end / gateway for your cluster
gateway="1.2.3.4"
# Your master node
master="10.0.0.1"

iptables -F
iptables -F INPUT
iptables -F OUTPUT
iptables -F POSTROUTING -t nat
iptables -F PREROUTING -t nat

modprobe iptable_nat
iptables -t nat -A POSTROUTING -o $iface -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward

# Redirect para firewall
iptables -t nat -A PREROUTING -p tcp -d $gateway --dport 2223 -j DNAT --to-destination $master:22

