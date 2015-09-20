#!/bin/bash
# -----------------------------------------------------------------------------
# -- Base
# -----------------------------------------------------------------------------

install_base_a()
{
	echo "----------------------------------------------------------------------"
	echo "--"
	echo "-- Installing Base Packages"
	echo "--"
	echo "----------------------------------------------------------------------"

	echo "Installing Base A"
	apt-get update

	apt-get install -y -V git
	apt-get install -y -V screen curl vim exuberant-ctags zip libldap-2.4-2 ldap-utils
	apt-get install -y -V python-software-properties subversion
	apt-get install -y -V openjdk-6-jdk
}

install_base_b()
{
	echo "----------------------------------------------------------------------"
	echo "--"
	echo "-- Creating Config Files"
	echo "--"
	echo "----------------------------------------------------------------------"

	# Get config files
	git clone git://github.com/pabloviquez/mydotfiles.git /home/vagrant/.mydotfiles
	chown -R vagrant:vagrant /home/vagrant/.mydotfiles
	cp /home/vagrant/.mydotfiles/.vimrc /home/vagrant/
	cp /home/vagrant/.mydotfiles/.screenrc /home/vagrant/
}

CMDA=$(screen -v 2>&1)
if [[ $CMDA != *"Screen version"* ]]
then
	install_base_a
	install_base_b
fi