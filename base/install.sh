#!/bin/bash
# -----------------------------------------------------------------------------
# -- Base
# -----------------------------------------------------------------------------

install_base_a()
{
	echo "Installing Base A"
	sudo apt-get update

	sudo apt-get install -y -V git
	sudo apt-get install -y -V screen curl vim exuberant-ctags zip libldap-2.4-2 ldap-utils
	sudo apt-get install -y -V python-software-properties subversion
	sudo apt-get install -y -V openjdk-6-jdk
}

install_base_b()
{
	# Get config files
	git clone git://github.com/pabloviquez/mydotfiles.git ~/.mydotfiles
	cp ~/.mydotfiles/.vimrc ~
	cp ~/.mydotfiles/.screenrc ~
}

CMDA=$(screen -v 2>&1)
if [[ $CMDA != *"Screen version"* ]]
then
	install_base_a
	install_base_b
fi