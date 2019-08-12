#!/usr/bin/env bash

show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " CREATE SITE - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Laravel"
	echo "2. Apache"
	echo "3. Magento"
	echo "4. Proxy"
	echo "5. Wordpress"
	echo "6. Zend"
	echo "7. Symfony2"
	echo "8. Symfony4"
	echo "9. Go Back"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 9] " choice
	case $choice in
		1) source ./site-types/laravel.sh ;;
		2) source ./site-types/apache.sh ;;
		3) source ./site-types/magento.sh ;;
		4) source ./site-types/proxy.sh ;;
		5) source ./site-types/wordpress.sh ;;
		6) source ./site-types/zend.sh ;;
		7) source ./site-types/symfony2.sh ;;
		8) source ./site-types/symfony4.sh ;;
		9) source main.sh ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}