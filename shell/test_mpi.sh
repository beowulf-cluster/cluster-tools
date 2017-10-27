#!/bin/bash

# Basic test on mpi comunication

STime=$(date +%s)

mpiexec -n 600 -f .machines seq 0 999999999999999999999999999999 > /dev/null

ETime=$(date +%s)
echo "Elapsed Time: $(($ETime - $STime)) seconds"

