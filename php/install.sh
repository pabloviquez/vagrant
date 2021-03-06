#!/bin/bash
# -----------------------------------------------------------------------------
# -- PHP
# -----------------------------------------------------------------------------

install_php56()
{
  echo "Adding PHP 5.6 Repository"
  add-apt-repository ppa:ondrej/php
  apt-get update

  apt-get -y -V install php5
  apt-get -y -V install php5-dev
  apt-get -y -V install php5-cli php-pear php5-intl php5-sybase php5-apcu php5-curl php5-memcache php5-memcached php-gettext php5-gd php5-ldap php5-imagick php5-mcrypt php5-mysqlnd phpunit php5-xdebug

  pear update-channels
}

install_php70()
{
  echo "Adding PHP 7.0 Repository"
  add-apt-repository ppa:ondrej/php
  apt-get update

  apt-get -y -V install php7.0
  apt-get -y -V install php7.0-dev
  apt-get -y -V install php7.0-cli php7.0-curl php7.0-soap php-pear php7.0-intl php7.0-sybase php7.0-apcu php7.0-curl php7.0-memcache php7.0-memcached php-gettext php7.0-gd php7.0-ldap php7.0-imagick php7.0-mcrypt php7.0-mysqlnd phpunit php7.0-xdebug

  pear update-channels
}

install_drush()
{
  wget http://files.drush.org/drush.phar
  php drush.phar core-status
  chmod +x drush.phar
  mv drush.phar /usr/local/bin/drush
}

CMDA=$(php -v 2>&1)
if [[ $CMDA != *"PHP 7.0"* ]]
then
  install_php70
  install_drush
fi
