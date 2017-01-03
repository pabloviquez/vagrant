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
  echo "-- New config file: /etc/nginx/sites-available/default01"
  echo "--"
  echo "-- Creating new PHP index page with PHP Info"
  echo "----------------------------------------------------------------------"

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
                fastcgi_pass unix:/run/php/php7.1-fpm.sock;
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

  cat << EOF > /var/www/html/index.php
<h1>NGINX Page</h1>
<p>Default page for the NGINX web server</p>

<pre><?php
echo 'Current file: ' __FILE__;
echo "\n";
echo 'Server Software: ' . $_SERVER['SERVER_SOFTWARE'];
?></pre>

<hr>
<?php phpinfo(); ?>

EOF
}


CMDA=$(nginx -v 2>&1)
if [[ $CMDA != *"nginx"* ]]
then
    install_nginx
    update_nginx_config

    echo ""
    echo "----------------------------------------------------------------------"
    echo "--"
    echo "-- NGinx Setup Completed"
    echo "--"
    echo "----------------------------------------------------------------------"
fi


