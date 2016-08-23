<h1>Vagrant Ubuntu Provision File</h1>

<h2>Install</h2>

Add the RAW setup script to the Vagrantfile as provision

```
Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/pabloviquez/vagrant/1.1.5/setup.sh"
end
```

<h2>What does this thing do?</h2>

Simple, I created this repository to have a simple provisioning standard setup script for Vagrant Ubuntu Machines.

<h2>Packages to Install</h2>

<h3>Base Packages</h3>
<ul>
	<li>git</li>
	<li>screen</li>
	<li>curl</li>
	<li>vim</li>
	<li>exuberant-ctags</li>
	<li>zip</li>
	<li>libldap-2.4-2</li>
	<li>ldap-utils</li>
	<li>python-software-properties</li>
	<li>subversion</li>
	<li>openjdk-6-jdk</li>
</ul>

<h3>Utility &amp; Development</h3>
<ul>
	<li>Apache 2.4.x</li>
	<li>PHP 5.6.x</li>
	<ul>
		<li>Dev</li>
		<li>CLI</li>
		<li>APCU</li>
		<li>Memcache</li>
		<li>Memcached</li>
		<li>GetText</li>
		<li>GD</li>
		<li>LDAP</li>
		<li>Imagick</li>
		<li>MCrypt</li>
		<li>Mysqlnd</li>
		<li>PHPUnit</li>
		<li>XDebug</li>
	</ul>
	<li>PEAR</li>
	<li>Drush</li>
	<li>MySQL 5.6.x</li>
	<ul>
		<li>Default Password: <strong>123456</strong></li>
		<li>Set default connection &amp; database charset: <strong>UTF-8</strong><br><pre>/etc/mysql/conf.d/utf8.cnf</pre></li>
		<li>Created Slow query log configuration file. Log to TABLE and disabled by default<br><pre>/etc/mysql/conf.d/slowquery.cnf</pre></li>
	</ul>
</ul>

An additional Repository will be installed for dot configuration files. https://github.com/pabloviquez/mydotfiles


