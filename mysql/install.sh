#!/bin/bash
# -----------------------------------------------------------------------------
# -- MySQL
# -----------------------------------------------------------------------------

install_mysql56()
{
	echo "Installing MySQL 5.6"
	sudo add-apt-repository ppa:ondrej/mysql-5.6
	sudo apt-get update
	sudo apt-get install mysql-server mysql-common mysql-client-5.6
}

install_configfiles()
{
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
	echo "# Setting the slow query log" > /etc/mysql/conf.d/slowquery.cnf && \
	echo "[mysqld]" >> /etc/mysql/conf.d/slowquery.cnf && \
	echo "log-output=TABLE" >> /etc/mysql/conf.d/slowquery.cnf && \
	echo "long_query_time=0" >> /etc/mysql/conf.d/slowquery.cnf && \
	echo "min_examined_row_limit=1" >> /etc/mysql/conf.d/slowquery.cnf && \
	echo "slow_query_log=0" >> /etc/mysql/conf.d/slowquery.cnf && \
	service mysql restart
}

install_mysql56
install_configfiles