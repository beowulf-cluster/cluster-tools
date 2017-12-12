#!/bin/bash

# Install basic cluster packages

echo "Preparing basic system packages"

echo "Reconfiguring locales"

dpkg-reconfigure locales

echo "Installing basic packages"

apt-get update
apt-get upgrade

apt-get install git vim ranger tree htop build-essential mpich nis
