#!/bin/bash

# install script for dooh Raspberyy pi project
# jlcf <dooh@jlcf.org>

# Go to pi home folder
cd /home/pi

# Install package
apt-get install xrdp libreoffice x11vnc ntpdate

# make dooh account

# get zip archive from github dooh project

# unzip archive

# Fix rights on dooh tree

# Update rc.d for
update-rc.d pi-sftp defaults  

# Run dooh with default slide show
su pi
/home/pi/dooh/bin/doohrun

exit 0
