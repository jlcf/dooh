#!/bin/bash

# install script for dooh Raspberyy pi project
# jlcf <dooh@jlcf.org>

PASSWDOOH="doohmgr"

echo "Install DOOH module on Raspberry PI"

if [ -e /home/pi/dooh-master.zip]; then

	# Go to pi home folder
	cd /home/pi

	# Install package
	apt-get install xrdp libreoffice x11vnc ntpdate

	# make dooh account
	adduser --system --shell /bin/bash --group --disabled-password --home /home/pi/dooh dooh
	echo dooh:$PASSWDOOH | chpasswd

	# unzip archive
        unzip dooh-master.zip
	# cp  and clean files
        cd dooh-master/raspdooh
        find . -name .DS_Store -exec rm -f {} \;
        cp -r * /
	# Fix rights on dooh tree

	# Update rc.d for
	update-rc.d pi-sftp defaults  

	# Run dooh with default slide show
	su pi
	/home/pi/dooh/bin/doohrun
else
	echo "No raspdooh archive found !"
        echo "get https://github.com/jlcf/dooh/archive/master.zip"
	echo "Put in /home/pi and run again install.sh"
	exit 1
fi
exit 0
