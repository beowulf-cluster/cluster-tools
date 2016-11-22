#!/bin/bash

echo "Stopping Torque Services:"
torqueman stop


SERVER_NAME="masterus"

NODES=("masterus" "slaveus")

# DEBUG - checking array

echo -e "\n===== DEBUG ===="
echo "Array 1: ${NODES[0]};"
echo "Array 2: ${NODES[1]};"
echo -e "\n===== END DEBUG ===="

# Resets default options
echo -e "Creating new Torque Server Configuration\n"
#pbs_server -t create

echo -e "Killing PBS_Server Instance for manual configuration...\n"
killall pbs_server

echo "The server name is: $SERVER_NAME"

echo -e "Setting up environment...\n"

echo $SERVER_NAME > /etc/torque/server_name
echo $SERVER_NAME > /var/spool/torque/server_priv/acl_svr/acl_hosts

# The managers must be root!
echo root@$SERVER_NAME > /var/spool/torque/server_priv/acl_svr/operators
echo root@$SERVER_NAME > /var/spool/torque/server_priv/acl_svr/managers

echo "Setting up compute nodes!"

echo "${NODES[0]} np=1" > /var/spool/torque/server_priv/nodes
echo "${NODES[1]} np=2" >> /var/spool/torque/server_priv/nodes

echo -e "Checking config:\n"

cat /var/spool/torque/server_priv/nodes
cat /etc/torque/server_name
cat /var/spool/torque/server_priv/acl_svr/acl_hosts
cat /var/spool/torque/server_priv/acl_svr/operators
cat /var/spool/torque/server_priv/acl_svr/managers

echo "Starting Torque Services:"
torqueman start
