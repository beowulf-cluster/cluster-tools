#!/bin/bash

echo "Adding IAR repository..."
echo "#IAR Project" >> /etc/apt/sources.list.d/iar.list
echo "deb http://nis-replacement.org/deb ./" >> /etc/apt/sources.list.d/iar.list

echo "Adding Verification Key"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EE56AC32AF86804F 3D1B4D6844E2DC44

echo "Installing Server..."

apt-get update
apt-get install iar-server
