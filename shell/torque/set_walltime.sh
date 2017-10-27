#!/bin/bash

# === WORK IN PROGRESS ===

# changes default walltime for your PBS

qmgr -c 'set queue fistat resources_default.walltime = 48:00:00'

