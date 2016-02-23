#!/usr/bin/env bash

sudo apt-get install nfs-client && sudo apt-get install nfs-common

sudo echo "cl-node-1.local:/home/pi/camino /home/pi/camino  nfs"
