#!/bin/bash

qmgr -c 'create queue ubuntu'
qmgr -c 'set queue ubuntu queue_type = execution'
qmgr -c 'set queue ubuntu started = true'
qmgr -c 'set queue ubuntu enabled = true'
qmgr -c 'set queue ubuntu resources_default.walltime = 00:01:00'
qmgr -c 'set queue ubuntu resources_default.nodes = 2'
qmgr -c 'set server default_queue = ubuntu'

# Server atributes
qmgr -c 'set server scheduling = true'
qmgr -c 'set server keep_completed = 300'
qmgr -c 'set server mom_job_sync = true'

# Submission pool
qmgr -c 'set server submit_hosts = masterus'
qmgr -c 'set server allow_node_submit = true'
