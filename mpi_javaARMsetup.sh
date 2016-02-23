#!/usr/bin/env bash

cd ~/
wget https://drive.google.com/file/d/0BwHHQtqX4oMLOEtVTWd6VklRNnM/view?usp=sharing

sudo tar zxvf jdk-8u73-linux-arm32-vfp-hflt.tar.gz -C /opt

sleep 5

sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_73/bin/javac 1
sudo update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_73/bin/java 1

sleep 3

sudo update-alternatives --config javac
sudo update-alternatives --config java
