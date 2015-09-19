#!/bin/bash
# -----------------------------------------------------------------------------
# -- Ubuntu Install Script
# -- 
# -- @author Pablo Viquez
# --
# -- https://raw.githubusercontent.com/pabloviquez/vagrant/master/setup.sh
# -----------------------------------------------------------------------------

echo "------------------------------------------------------------------------------"
echo "--"
echo "-- Ubuntu Provision Script"
echo "--"
echo "--"
echo "------------------------------------------------------------------------------"

if [ ! -d ~/provision ]; then
	sudo apt-get update
	sudo apt-get install -y -V git
	ssh -oStrictHostKeyChecking=no -T git@github.com
	git clone git://github.com/pabloviquez/vagrant.git ~/provision
fi

if [ -d ~/provision ]; then
	cd ~/provision
	source base/install.sh
	source apache/install.sh
	source php/install.sh
	source mysql/install.sh
else
	echo "Unable to setup the machine. Provision directory not found"
fi