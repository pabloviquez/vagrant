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
  echo "Adding PHP 7.x Repository"
  add-apt-repository ppa:ondrej/php
  apt-get update

  apt-get -y -V install php7.0
  apt-get -y -V install php7.0-dev
  apt-get -y -V install php7.0-cli php7.0-curl php7.0-soap php-pear php7.0-intl php7.0-sybase php7.0-apcu php7.0-curl php7.0-memcache php7.0-memcached php-gettext php7.0-gd php7.0-ldap php7.0-imagick php7.0-mcrypt php7.0-mysqlnd phpunit php7.0-xdebug

  pear update-channels
}

install_php71_fpm()
{
  echo "Adding PHP 7.x Repository"
  add-apt-repository ppa:ondrej/php
  apt-get update

  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Installing PHP 7.1.x"
  echo "--"
  echo "----------------------------------------------------------------------"
  apt-get -y -V install php7.1-fpm php7.1-common php7.1-json php7.1-opcache php7.1-cli
  apt-get -y -V install php7.1-dev php7.1-xml
  apt-get -y -V install php7.1-bcmath php7.1-pspell php7.1-readline
  apt-get -y -V install php7.1-imagick php7.1-gd
  apt-get -y -V install php7.1-curl php7.1-intl php7.1-json php7.1-soap php7.1-tidy
  apt-get -y -V install php7.1-ldap php7.1-mbstring php7.1-mcrypt php7.1-bz2 php7.1-zip
  apt-get -y -V install php7.1-dba php7.1-interbase php7.1-mysql php7.1-odbc php7.1-pgsql php7.1-sqlite3 php7.1-sybase
  apt-get -y -V install php-memcached php-memcache php-nrk-predis
  apt-get -y -V install php-xdebug
  apt-get -y -V install php-pear php-gettext phpunit
}

install_drush()
{
  wget http://files.drush.org/drush.phar
  php drush.phar core-status
  chmod +x drush.phar
  mv drush.phar /usr/local/bin/drush
}

CMDA=$(php -v 2>&1)
if [[ $CMDA != *"PHP 7"* ]]
then
  install_php71_fpm
  install_drush
fi
