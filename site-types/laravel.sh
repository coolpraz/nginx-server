#!/usr/bin/env bash
clear
read -p "Enter your domain name and press [ENTER]: " domainName
read -p "Enter your root path(Absolute path) and press [ENTER]: " serverRoot
read -p "Enter HTTP port number [80]: " defaultPort
read -p "Enter HTTPS port number [443]: " sslPort

PS3='Please enter PHP version of your choice: '
options=("7.3" "7.2" "7.1" "7.0" "5.6")
select opt in "${options[@]}"
do
  case $opt in
    "7.3")
      phpVer="7.3"
    break
    ;;
    "7.2")
      phpVer="7.2"
    break
    ;;
    "7.1")
      phpVer="7.1"
    break
    ;;
    "7.0")
      phpVer="7.0"
    break
    ;;
    "5.6")
      phpVer="5.6"
    break
    ;;
    *) echo invalid option;;
  esac
done

domain=$domainName
rootpath=$serverRoot
defaultPort=${defaultPort:-80}
sslPort=${sslPort:-443}

# Create the Document Root directory
if [ ! -d $rootpath ]; then
  mkdir -p $rootpath 2>/dev/null
  # Assign ownership to your regular user account
  chown -R $SUDO_USER:$SUDO_USER $rootpath 2>/dev/null
fi

source create-certificate.sh

block="server {
    listen $defaultPort;
    listen $sslPort ssl http2;
    server_name .$domain;
    root \"$rootpath\";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/$domain-error.log error;

    sendfile off;

    client_max_body_size 100m;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php$phpVer-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;

        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }

    location ~ /\.ht {
        deny all;
    }

    ssl_certificate     /etc/nginx/ssl/$domain.crt;
    ssl_certificate_key /etc/nginx/ssl/$domain.key;
}
"

sudo echo "$block" > "/etc/nginx/sites-available/$domain"
sudo ln -fs "/etc/nginx/sites-available/$domain" "/etc/nginx/sites-enabled/$domain"

sudo service nginx restart
sudo service php7.2-fpm restart
sudo service php7.3-fpm restart
sudo service php7.1-fpm restart
sudo service php7.0-fpm restart
sudo service php5.6-fpm restart

pause
return