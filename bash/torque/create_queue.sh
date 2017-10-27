#!/bin/bash

# ==================================================================
# This script sets up a default queue for the Torque Resource Manager.
# Since I don't want unpackaged installs, I used Ubuntu default repository package. 
# The commands described here may work with later versions of torque since the examples were taken from the latest version of documentation.
# ==================================================================

# Torque is a very complete solution, so some basic configuration is needed to put it to work. You MUST create a queue even if you intend to use it as a simple serial job manager

# Name your queue here
my_queue="cluster_queue"

# Deletes the previous queue (let"s start fresh!)
qmgr -c "delete queue $my_queue"

# Creates main queue and sets up some basic starting points for your
# Batch System:

qmgr -c "create queue $my_queue"

# Type of queue: basic is execution. Another is routing
# Check documentation for details
qmgr -c "set queue $my_queue queue_type = execution"

# Just starts the queue. If you turn this to false, the jobs are submitted, but never started
qmgr -c "set queue $my_queue started = true"

# Enables the queue
qmgr -c "set queue $my_queue enabled = true"

# Since Torque is a resource manager, you MUST set a walltime and compute nodes
#
qmgr -c "set queue $my_queue resources_default.walltime = 00:00:30"
qmgr -c "set queue $my_queue resources_default.nodes = 3"

# The server needs a fallback queue if none is specified in job submission
qmgr -c "set server default_queue = $my_queue"

# Server atributes (need some research. Feel free to contribute
qmgr -c "set server scheduling = true"
qmgr -c "set server keep_completed = 300"
qmgr -c "set server mom_job_sync = true"

# Submission pool: which hosts can submit jobs
qmgr -c "set server submit_hosts = my_torque.server.fqdn"
qmgr -c "set server submit_hosts += a_slave.server.fqdn"
qmgr -c "set server allow_proxy_user = true"

# Allows compute nodes to submit jobs
qmgr -c "set server allow_node_submit = true"

