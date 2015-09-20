#!/bin/bash
# -----------------------------------------------------------------------------
# -- Apache
# -----------------------------------------------------------------------------


install_apache()
{
	echo "Adding Apache2 repository"
	# apt-add-repository ppa:ptn107/apache
	add-apt-repository ppa:ondrej/apache2
	apt-get update

	echo "Installing Apache2"
	apt-get -y -V install apache2

	echo "Enabling Apache Extensions"
	# apt-get install libapache2-mpm-itk apache2-mpm-itk

	a2enmod proxy
	a2enmod rewrite
	a2enmod headers
	service apache2 restart
}

CMDA=$(apache2 -v 2>&1)
if [[ $CMDA != *"Apache server"* ]]
then
	install_apache
fi