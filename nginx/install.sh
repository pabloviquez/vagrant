#!/bin/bash
# -----------------------------------------------------------------------------
# -- NGinx
# -----------------------------------------------------------------------------

install_nginx()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Installing NGINX"
  echo "--"
  echo "----------------------------------------------------------------------"

  apt-get update
  apt-get -y -V install nginx
}

update_nginx_config()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Changing NGINX deafault configuration to support PHP 7.1 FPM"
  echo "--"
  echo "-- Config changes:"
  echo "--"
  echo "--   1. Set NGINX user to be ubuntu"
  echo "--   2. New config file: /etc/nginx/sites-available/default01"
  echo "--   3. Creating new PHP index page with PHP Info"
  echo "--   4. Changing owner of HTML directory to be ubuntu instead of root"
  echo "--"
  echo "----------------------------------------------------------------------"

  sed -i.bak 's/user ubuntu;/user www-user;/' nginx.conf

  cat << EOF > /etc/nginx/sites-available/default01

server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.php

        server_name _;

        location / {
                try_files $uri $uri/ =404;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.1-fpm-vagrant.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}

EOF
  
  # Enable new config
  rm /etc/nginx/sites-enabled/default
  ln -s /etc/nginx/sites-available/default01 /etc/nginx/sites-enabled/default

  service nginx restart
  journalctl -n 4

  cat << 'EOF' > /var/www/html/index.php
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>

<pre><?php
echo 'Current file: ' . __FILE__;
echo "\n";
echo 'Server Software: ' . $_SERVER['SERVER_SOFTWARE'];
?></pre>

<hr>
<?php phpinfo(); ?>

EOF

  chown -R ubuntu:ubuntu /var/www/html
}


install_nginx
update_nginx_config
systemctl status nginx.service

echo ""
echo "----------------------------------------------------------------------"
echo "--"
echo "-- NGinx Setup Completed"
echo "--"
echo "----------------------------------------------------------------------"

