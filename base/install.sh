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
  apt-get install -y -V tcl
  apt-get install -y -V python-software-properties subversion
  apt-get install -y -V openssl
  apt-get install -y -V openjdk-6-jdk
  apt-get install -y -V memcached
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

install_locales()
{
  export LC_ALL="en_US.UTF-8"
  locale-gen --purge en_US en_US.UTF-8
}

CMDA=$(screen -v 2>&1)
if [[ $CMDA != *"Screen version"* ]]
then
  install_locales
  install_base_a
  install_base_b
fi
