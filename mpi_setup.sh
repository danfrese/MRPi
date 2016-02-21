#!/bin/sh

# Name: mpi_setup.sh
# Author: Dan Frese
# Written: 2/20/2016
# Modified: 2/20/2016
#
# Prerequisites: Must have root access (sudo will not work) and a C compiler
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
echo "\nUpdating packages and installing gfortran.\n"
apt-get update
apt-get install gfortran -y

mkdir /home/pi/mpich
cd /home/pi/mpich

# Download & unpack the MPI sources
echo "\nDownloading and unpacking.\n"
wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
tar xfz mpich-3.2.tar.gz

# Make yourself a place to put the compiled files.
# This will make it easier to figure out what the new files are since it's
# 	likely that you'll end up building this a few times.
echo "\nMaking compiled file directories.\n"
mkdir /home/rpimpi/
mkdir /home/rpimpi/mpich-install

# Make a build directory so we can keep the source dir clean of build items
echo "\nMaking build directory.\n"
mkdir /home/pi/mpich_build
cd /home/pi/mpich_build

# Configure the build and go for a walk (~5 - 10 minutes)
echo "\nBuilding...\n"
/home/pi/mpich/mpich-3.2/configure -prefix=/home/rpimpi/mpich-install 2>&1 | tee c.txt

# Make the files and go for another walk (~30 - 45 minutes)
# This is somewhat dependant on if you've overclocked your Pi or not
echo "\nMaking...\n"
make 2>&1 | tee m.txt

# This step should succeed if there were no problems. If there were, do the following:
#	make clean
#	make VERBOSE=1 2>&1 | tee m.txt (for bash and sh)

# Install the files and go for another walk (<5 minutes)
echo "\nInstalling...\n"
make install 2>&1 | tee mi.txt

# Permanently add the path to where you put the installation files
echo '# MPI install path' |  tee -a /etc/profile
echo 'PATH="$PATH:/home/rpimpi/mpich-install/bin"' |  tee -a /etc/profile

# Check whether things were installed or not
# TODO: check if the make and make install were successful
echo "Checking whether things were installed or not."
echo "IDK how to do this yet..."
which mpicc
which mpiexec

# Move back to home dir and create a MPI testing dir
echo "Creating & moving to MPI testing dir"
cd /home/pi
mkdir mpi_testing
cd mpi_testing
