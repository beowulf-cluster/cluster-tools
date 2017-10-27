#!/bin/bash

# This script sets up your initial Torque Environment. 
# 
# When you set up your first scheduler, you will test it A LOT. Sometimes, things brake. This is just a helper for resetting your environment again after a crash
# 
# If you compiled Torque from source, use the script shipped with it.
#
# It still needs some work. Maybe I will write it in python

# This script depends on torqueman.sh (check 'torque' directory in the repository)
echo "Stopping Torque Services:"
torqueman stop

# Your main compute node
SERVER_NAME="my_scheduler.fqdn.local"

# The compute nodes of your cluster
NODES=("slave1" "slave2" "slave3")

# DEBUG - checking array

echo -e "\n===== DEBUG ===="
echo "Array 1: ${NODES[0]};"
echo "Array 2: ${NODES[1]};"
echo -e "\n===== END DEBUG ===="

# Resets default options. 
# =====================
#   WARNING!
# =====================
# This command will erase ALL your previous Torque database!
echo -e "Creating new Torque Server Configuration:\n"
pbs_server -t create

# This is a prerequisite even in newer versions of Torque:
echo -e "Killing PBS_Server Instance for manual configuration...\n"
killall pbs_server

echo "The server name is: $SERVER_NAME"

echo -e "Setting up environment...\n"

# Sets up local environments
echo "Adding scheduler to himself"
echo $SERVER_NAME > /etc/torque/server_name
echo $SERVER_NAME > /var/spool/torque/server_priv/acl_svr/acl_hosts

# The managers must be root!
echo "Adding operators..."
echo root@$SERVER_NAME > /var/spool/torque/server_priv/acl_svr/operators
echo root@$SERVER_NAME > /var/spool/torque/server_priv/acl_svr/managers

# The 'np' directive specifies the number of virtual processors in your compute nodes
# Change as you need

# This needs some work. With bidimensional arrays or a JSON file would be less messy

echo "Setting up compute nodes!"

echo "${NODES[0]} np=4" > /var/spool/torque/server_priv/nodes
echo "${NODES[1]} np=6" >> /var/spool/torque/server_priv/nodes
echo "${NODES[2]} np=8" >> /var/spool/torque/server_priv/nodes

echo -e "Checking config:\n"

echo -e "\n"
cat /var/spool/torque/server_priv/nodes
cat /etc/torque/server_name
cat /var/spool/torque/server_priv/acl_svr/acl_hosts
cat /var/spool/torque/server_priv/acl_svr/operators
cat /var/spool/torque/server_priv/acl_svr/managers


# NEEDS adding a prompt here
echo "Starting Torque Services:"
torqueman start
