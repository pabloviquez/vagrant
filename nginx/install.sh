#!/bin/bash
# -----------------------------------------------------------------------------
# -- NGinx
# -----------------------------------------------------------------------------

install_nginx()
{
  echo "----------------------------------------------------------------------"
  echo "--"
  echo "-- Installing NGinx"
  echo "--"
  echo "----------------------------------------------------------------------"

  apt-get update
  apt-get -y -V install nginx
}

update_nginx_config()
{
  cat << EOF > /etc/nginx/sites-available/default01

server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.html index.php

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
}


if [[ $CMDA != *""* ]]
then
    install_nginx
    update_nginx_config

    echo "----------------------------------------------------------------------"
    echo "--"
    echo "-- NGinx Setup Completed"
    echo "--"
    echo "----------------------------------------------------------------------"
fi


