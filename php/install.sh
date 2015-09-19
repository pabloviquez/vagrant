#!/bin/bash
# -----------------------------------------------------------------------------
# -- PHP
# -----------------------------------------------------------------------------

install_php56()
{
	echo "Adding Latest Repositories - PHP"
	sudo add-apt-repository ppa:ondrej/php5-5.6
	sudo apt-get update

	sudo apt-get -y -V install php5
	sudo apt-get -y -V install php5-dev
	sudo apt-get -y -V install php5-cli php-pear php5-apcu php5-curl php5-memcache php5-memcached php-gettext php5-gd php5-ldap php5-imagick php5-mcrypt php5-mysqlnd phpunit php5-xdebug

	sudo pear channel-update
}

install_drush()
{
	sudo pear channel-discover pear.drush.org
	sudo pear install drush/drush
	sudo pear upgrade drush/drush
}

CMDA=$(php -v 2>&1)
if [[ $CMDA != *"PHP 5.6"* ]]
then
	install_php56
	install_drush
fi
