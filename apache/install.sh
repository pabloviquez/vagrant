#!/bin/bash
# -----------------------------------------------------------------------------
# -- Apache
# -----------------------------------------------------------------------------


install_apache()
{
	echo "----------------------------------------------------------------------"
	echo "--"
	echo "-- Adding Apache2.4 repository"
	echo "--"
	echo "----------------------------------------------------------------------"
	# apt-add-repository ppa:ptn107/apache
	add-apt-repository ppa:ondrej/apache2
	apt-get update

	echo "----------------------------------------------------------------------"
	echo "--"
	echo "-- Installing Apache 2.4"
	echo "--"
	echo "----------------------------------------------------------------------"
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

	echo "----------------------------------------------------------------------"
	echo "--"
	echo "-- Apache Setup Completed"
	echo "--"
	echo "----------------------------------------------------------------------"
fi