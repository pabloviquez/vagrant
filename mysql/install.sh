#!/bin/bash
# -----------------------------------------------------------------------------
# -- MySQL
# -----------------------------------------------------------------------------

install_mysql57()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Installing MySQL 5.7"
  echo "--"
  echo "--"
  echo "-- Default password: 123456"
  echo "----------------------------------------------------------------------"
  echo ""

  apt-get install -y -V  debconf-utils

  debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-tools select'
  debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-distro select ubuntu'
  debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-server select mysql-5.7'
  debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-product select Apply'

  export DEBIAN_FRONTEND=noninteractive
  wget http://dev.mysql.com/get/mysql-apt-config_0.7.3-1_all.deb
  # dpkg -i mysql-apt-config_0.7.3-1_all.deb
  dpkg --install mysql-apt-config_0.7.3-1_all.deb
  apt-get update

  # Set default password
  debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123456'
  debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123456'

  debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password 123456'
  debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password 123456'

  apt-get -y -V install mysql-server mysql-client
}

install_mysql56()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Installing MySQL 5.6"
  echo "--"
  echo "--"
  echo "-- Default password: 123456"
  echo "----------------------------------------------------------------------"
  echo ""

  wget http://dev.mysql.com/get/mysql-apt-config_0.6.0-1_all.deb
  dpkg -i mysql-apt-config_0.6.0-1_all.deb
  apt-get update

  # Set default password
  debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123456'
  debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123456'
  apt-get -y -V install mysql-server mysql-client
}

install_configfiles()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Setting up MySQL Configurations Files"
  echo "--"
  echo "-- Files:"
  echo "--       /etc/mysql/conf.d/utf8.cnf"
  echo "--       /etc/mysql/conf.d/slowquery.cnf"
  echo "--"
  echo "----------------------------------------------------------------------"

  echo ""
  echo ""
  echo "Setting All Connections to UTF-8"
  #
  # MySQL 5.6 UTF-8 Configurations
  #
  echo "# Setting All Connections to UTF-8" > /etc/mysql/conf.d/utf8.cnf && \
  echo "" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "[client]" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "default-character-set=utf8" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "[mysql]" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "default-character-set=utf8" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "[mysqld]" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "character-set-server = utf8" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "collation-server = utf8_general_ci" >> /etc/mysql/conf.d/utf8.cnf && \
  echo "init-connect='SET NAMES utf8'" >> /etc/mysql/conf.d/utf8.cnf && \
  service mysql restart

  #
  # MySQL Configurations SlowQueryLog
  #
  echo "Setting Slow Query Log - Disable by default"
  echo "# Setting the slow query log" > /etc/mysql/conf.d/slowquery.cnf && \
  echo "[mysqld]" >> /etc/mysql/conf.d/slowquery.cnf && \
  echo "log-output=TABLE" >> /etc/mysql/conf.d/slowquery.cnf && \
  echo "long_query_time=0" >> /etc/mysql/conf.d/slowquery.cnf && \
  echo "min_examined_row_limit=1" >> /etc/mysql/conf.d/slowquery.cnf && \
  echo "slow_query_log=0" >> /etc/mysql/conf.d/slowquery.cnf && \
  service mysql restart
}

CMDA=$(mysql --help 2>&1)
if [[ $CMDA != *"Distrib 5.7"* ]]
then
  install_mysql57
  install_configfiles
fi
