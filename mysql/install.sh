#!/bin/bash
# -----------------------------------------------------------------------------
# -- MySQL
# -----------------------------------------------------------------------------

install_mysql56()
{
	echo "Installing MySQL 5.6"
	sudo add-apt-repository ppa:ondrej/mysql-5.6
	sudo apt-get update

	# Set default password
	sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123456'
	sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123456'
	sudo apt-get -y -V install mysql-server mysql-common mysql-client-5.6
}

install_configfiles()
{
	#
	# MySQL 5.6 UTF-8 Configurations
	#
	sudo echo "# Setting All Connections to UTF-8" > /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "[client]" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "default-character-set=utf8" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "[mysql]" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "default-character-set=utf8" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "[mysqld]" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "character-set-server = utf8" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "collation-server = utf8_general_ci" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo echo "init-connect='SET NAMES utf8'" >> /etc/mysql/conf.d/utf8.cnf && \
	sudo service mysql restart

	#
	# MySQL Configurations SlowQueryLog
	#
	sudo echo "# Setting the slow query log" > /etc/mysql/conf.d/slowquery.cnf && \
	sudo echo "[mysqld]" >> /etc/mysql/conf.d/slowquery.cnf && \
	sudo echo "log-output=TABLE" >> /etc/mysql/conf.d/slowquery.cnf && \
	sudo echo "long_query_time=0" >> /etc/mysql/conf.d/slowquery.cnf && \
	sudo echo "min_examined_row_limit=1" >> /etc/mysql/conf.d/slowquery.cnf && \
	sudo echo "slow_query_log=0" >> /etc/mysql/conf.d/slowquery.cnf && \
	sudo service mysql restart
}

CMDA=$(mysql --help 2>&1)
if [[ $CMDA != *"Distrib 5.6"* ]]
then
	install_mysql56
	install_configfiles
fi
