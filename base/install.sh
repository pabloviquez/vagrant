#!/bin/bash
# -----------------------------------------------------------------------------
# -- Base
# -- v2
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
  apt-get install -y -V openssl-blacklist
  apt-get install -y -V dialog
}

install_base_b()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Creating Config Files"
  echo "--"
  echo "----------------------------------------------------------------------"

  # Get config files
  git clone git://github.com/pabloviquez/mydotfiles.git /home/ubuntu/.mydotfiles
  chown -R ubuntu:ubuntu /home/ubuntu/.mydotfiles
  cp /home/ubuntu/.mydotfiles/.vimrc /home/ubuntu/
  cp /home/ubuntu/.mydotfiles/.screenrc /home/ubuntu/
}

install_locales()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Setting Locale to UTF-8"
  echo "--"
  echo "----------------------------------------------------------------------"

  export LC_ALL="en_US.UTF-8"
  locale-gen --purge en_US en_US.UTF-8
}

change_ubuntu_password()
{
  echo 'ubuntu:ubuntu'|chpasswd
}

setup_bash_config_file()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Setup Bash Config file"
  echo "--"
  echo "----------------------------------------------------------------------"

  echo "" > /home/ubuntu/.bash_profile
  echo "#!/bin/bash" && \
  echo "" && \
  echo "export APPLICATION_ENV='vagrant'" >> /home/ubuntu/.bash_profile
  echo "export SYMFONY_ENV='vagrant'" >> /home/ubuntu/.bash_profile
}

install_locales
install_base_a
install_base_b
change_ubuntu_password
setup_bash_config_file
