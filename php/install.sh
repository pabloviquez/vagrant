#!/bin/bash
# -----------------------------------------------------------------------------
# -- PHP
# -----------------------------------------------------------------------------

install_php56()
{
	echo "Adding Latest Repositories - PHP"
	add-apt-repository ppa:ondrej/php5-5.6
	apt-get update

	apt-get -y -V install php5
	apt-get -y -V install php5-dev
	apt-get -y -V install php5-cli php-pear php5-apcu php5-curl php5-memcache php5-memcached php-gettext php5-gd php5-ldap php5-imagick php5-mcrypt php5-mysqlnd phpunit php5-xdebug

	pear channel-update
}

install_drush()
{
	pear channel-discover pear.drush.org
	pear install drush/drush
	pear upgrade drush/drush
}

CMDA=$(php -v 2>&1)
if [[ $CMDA != *"PHP 5.6"* ]]
then
	install_php56
	install_drush
fi
