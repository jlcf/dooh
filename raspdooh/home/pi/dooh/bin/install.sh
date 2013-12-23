#!/bin/bash

# install script for dooh Raspberry pi project
# jlcf <dooh@jlcf.org>

PASSWDOOH="doohmgr"

echo "Install DOOH module on Raspberry PI"

if [ -e /home/pi/master.zip]; then

	# Go to pi home folder
	cd /home/pi

	# Install package
	apt-get install xrdp libreoffice x11vnc ntpdate
	# unzip archive
	if [ ! -d dooh-master ]; then
        	unzip master.zip
	fi
	# cp  and clean files
    cd dooh-master/raspdooh
    find . -name .DS_Store -exec rm -f {} \;
    cp -r * /
    # make dooh account
	adduser --system --shell /bin/bash --ingroup pi --disabled-password --home /home/pi/dooh dooh
	echo dooh:$PASSWDOOH | chpasswd
	# pi account for x11vnc
	mkdir .vnc
	x11vnc -storepasswd "screenmgr" .vnc/passwd
	chown chown -R pi:pi .vnc
	# Fix rights on dooh tree
    chown pi:crontab /var/spool/cron/crontabs/pi
	chmod 600 /var/spool/cron/crontabs/pi
	chown root:pi root:pi /home/pi
	chmod 750 /home/pi
    chown -R pi:pi /home/pi/*
	chmod -R 775 /home/pi/*
	chown root:pi /home/pi/dooh
	chmod 750 /home/pi/dooh
	chown -R dooh:pi /home/pi/dooh/*
	chmod -R 755 /home/pi/dooh/*
	chmod 770 /home/pi/dooh/slides
	# Update rc.d for
	update-rc.d pi-sftp defaults  
	# Start pi-sftp service
	/etc/init.d/pi-sftp start
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
