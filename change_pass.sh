#!/bin/bash

pass=$(mkpasswd -m sha-512 teste)

puppet resource user fulano password=$pass


