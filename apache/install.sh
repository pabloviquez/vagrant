#!/bin/bash
# -----------------------------------------------------------------------------
# -- Apache
# -----------------------------------------------------------------------------


install_apache()
{
	echo "Adding Apache2 repository"
	# sudo apt-add-repository ppa:ptn107/apache
	sudo add-apt-repository ppa:ondrej/apache2
	sudo apt-get update

	echo "Installing Apache2"
	apt-get -y -V install apache2

	echo "Enabling Apache Extensions"
	# apt-get install libapache2-mpm-itk apache2-mpm-itk

	sudo a2enmod proxy
	sudo a2enmod rewrite
	sudo a2enmod headers
	sudo service apache2 restart
}

CMDA=$(apache2 -v 2>&1)
if [[ $CMDA != *"Apache server"* ]]
then
	install_apache
fi