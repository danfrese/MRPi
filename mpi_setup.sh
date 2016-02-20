#!/bin/sh

# Name: mpi_setup.sh
# Author: Dan Frese
# Written: 2/20/2016
# Modified: 2/20/2016
#
# Summary: This script will automatically download & install the Fortran compiler,
#	download and configure MPI source.
#
# Notes: This setup script was created with modifications from the following links:
# 		https://www.southampton.ac.uk/~sjc/raspberrypi/pi_supercomputer_southampton.htm
#		https://www.mpich.org/static/downloads/3.2/mpich-3.2-installguide.pdf

# Update package repo list and install Fortran
# The packages from gfortran are built for armel and we need armhf which is 
# 	why we are compiling all this ourselves.
echo "Updating packages and installing gfortran.\n"
sudo apt-get update
sudo apt-get install gfortran -y

sudo mkdir /home/pi/mpich
cd ~/mpich

# Download & unpack the MPI sources
echo "Downloading and unpacking.\n"
sudo wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
sudo tar xfz mpich-3.2.tar.gz

# Make yourself a place to put the compiled files.
# This will make it easier to figure out what the new files are since it's
# 	likely that you'll end up building this a few times.
echo "Making compiled file directories.\n"
sudo mkdir /home/rpimpi/
sudo mkdir /home/rpimpi/mpich3.2-install

# Make a build directory so we can keep the source dir clean of build items
echo "Making build directory.\n"
sudo mkdir /home/pi/mpich_build
cd /home/pi/mpich_build

# Configure the build and go for a walk (~5 - 10 minutes)
echo "Configuring build...\n"
sudo /home/pi/mpich/mpich-3.2/configure -prefix=/home/rpimpi/mpich3.2-install

# Make the files and go for another walk (~15 - 30 minutes)
echo "Making...\n"
sudo make

# Install the files and go for another walk ( minutes)
echo "Installing...\n"
sudo make install

# Add the place that you put the install to your path
echo '# MPI install path' | sudo tee -a /etc/profile
echo 'PATH="$PATH:/home/rpimpi/mpich3.2-install/bin"' | sudo tee -a /etc/profile