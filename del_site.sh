#!/usr/bin/env bash

clear

PS3='Please enter Service to delete its site: '
options=("Apache2" "Nginx")
select opt in "${options[@]}"
do
  case $opt in
    "Apache2")
      SRV="7.3"
    break
    ;;
    "Nginx")
      phpVer="7.2"
    break
    ;;
    *) echo invalid option;;
  esac
done

read -p "Enter your site domain name to delete and press [ENTER]: " domainName
dir_name=${domainName%.*}
read -p "Enter your Directory name and press [$dir_name]: " serverRoot

domain=$domainName
rootpath="/home/$SUDO_USER/${serverRoot:-$dir_name}"

# Delete the Document Root directory
if [ -d $rootpath ]; then
  rm -rf $rootpath 2>/dev/null
fi

PATH_SSL="/etc/nginx/ssl"
PATH_SITE="/etc/nginx/sites-available"
PATH_EN="/etc/nginx/sites-enabled"

dom_site="${PATH_SITE}/${domain}"
site_en="${PATH_EN}/${domain}"

if [ -f $dom_site ]
then
	rm -f $dom_site
	rm -f $site_en
fi

PATH_CNF="${PATH_SSL}/${domain}.cnf"
PATH_CRT="${PATH_SSL}/${domain}.crt"
PATH_CSR="${PATH_SSL}/${domain}.csr"
PATH_KEY="${PATH_SSL}/${domain}.key"

if [ -f $PATH_CNF ] || [ -f $PATH_KEY ] || [ -f $PATH_CRT ] || [ -f $PATH_CSR ]
then
	rm -f $PATH_SSL/${domain}.*
fi

pause
return

