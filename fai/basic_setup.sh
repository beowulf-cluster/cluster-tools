#!/bin/bash

# This script adds the fai project main repository to the sources.list and performs a simple server install
wget -O - https://fai-project.org/download/074BCDE4.asc | apt-key add -
echo "deb http://fai-project.org/download stretch koeln" > /etc/apt/sources.list.d/fai.list
apt-get update
apt-get install fai-quickstart

echo "Adding fai repository to nfsroot"
sed -i -e 's/^#deb/deb/' /etc/fai/apt/sources.list
sed -i -e 's/#LOGUSER/LOGUSER/' /etc/fai/fai.conf
