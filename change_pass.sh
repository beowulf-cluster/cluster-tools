#!/bin/bash
#
# This script is intended for being used with puppet for password generation.
#
# This script depends on the package "whois", which gives the 'mkpasswd' tool

#sudo apt-get update
#sudo apt-get install whois

# This command generates a random password.
#alnum=`date +%s | sha256sum | base64 | head -c 32`

echo "Type a password:"

read pass

# This command converts your password into a Unix Shadow type password using the
# best encription available

unix_pass=$(mkpasswd -m sha-512 $pass)

echo -e "\nThe password generated is: \n "
echo -e "=================================\n"
echo $unix_pass
echo -e "\n=================================\n"
