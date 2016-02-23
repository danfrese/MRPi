#!/usr/bin/env bash

sudo apt-get install nfs-server

echo "/home/pi/camino *(rw,sync,no_root_squash)" | sudo tee -a /etc/exports

sudo service nfs-kernel-server restart
