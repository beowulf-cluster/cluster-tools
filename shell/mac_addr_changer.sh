#!/bin/bash

# This script  is intended to change the mac address of an interface
# For specific usage inside my infrastructure

# This script is optional

#Declaring interface
iface=my_iface00

ifdown $iface

# Changes iface macaddres until next reboot
ifconfig $iface hw ether 00:12:34:56:78:90

ifup $iface
