#!/bin/sh

#
#         Apache2 Centos Basic Install
#         Copyright (c) 2020 Mrmagicpie
#
#      https://centos-apache.mrmagicpie.xyz
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Checking if root
#
dir=$(pwd)

if [ $EUID -ne 0 ]; then

   echo "|---------------------------------------------------------|"
   echo "|  You are not root! Please use sudo or root to run this  |"
   echo "|                         script!                         |"
   echo "|                                                         |"
   echo "|              Exiting Apache2 Configuration!             |"
   echo "|---------------------------------------------------------|"

   exit

fi
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Checking if Curl is installed
#
if ! [ -x "$(command -v curl)" ]; then

    echo "|---------------------------------------------------------|"
    echo '|              Error: curl is not installed.              |'
    echo "|---------------------------------------------------------|"

    ip4="Your server's IP"

else; then

    ip4=$(curl ifconfig.me)

fi
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Checking if Apache2 is installed
#
if ! [ -x "$(command -v apache2)" ]; then

    echo "|---------------------------------------------------------|"
    echo '|             Error: Apache2 is not installed.            |'
    echo "|                                                         |"
    echo "|      You need Apache2 to add a VHost! Install here:     |"
    echo "|  https://centos-apache.mrmagicpie.xyz/script/install.sh |"
    echo "|---------------------------------------------------------|"

    sleep 3

    exit

fi
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Starting the setup
#
echo "|---------------------------------------------------------|"
echo "|Welcome to the Apache2 Domain addition. Please make sure |"
echo "|you have a fully qualified domain name, and SSL to match.|"
echo "|   Your SSL must be in $dir, in .pem, and .key files.    |"
echo "|                                                         |"
echo "|         Please configure three DNS records!             |"
echo "|                 Name:   Type:   Target:                 |"
echo "|                  @       A   $ip4               |"
echo "|                  *       A   $ip4               |"
echo "|                  www    CNAME     @                     |"
echo "|                                                         |"
echo "|    Please type below your fully qualified domain name   |"
echo "|                  EX: mrmagicpie.xyz                     |"
echo "|---------------------------------------------------------|"
echo " "

read domain
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Asking if they want to setup with their domain
#
echo "|---------------------------------------------------------|"
echo "|     Configure Apache2 with the domain: $domain?     |"
echo "|                                                         |"
echo '|     Please say "y" to continue, and "n" to stop         |'
echo "|---------------------------------------------------------|"
echo " "

read continue

if [ "$continue" = "n" ] || [ "$continue" = "no" ]; then

	echo "|---------------------------------------------------------|"
	echo "|              Exiting Apache2 configuration.             |"
	echo "|---------------------------------------------------------|"

	sleep 3

	exit

elif [ "$continue" != "y" ]; then

  echo "|---------------------------------------------------------|"
  echo "|                     Invalid option!                     |"
  echo "|---------------------------------------------------------|"

  sleep 3

  exit

fi
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Making sure people have SSL
#
echo "|---------------------------------------------------------|"
echo "|              This Configuration requires SSL!           |"
echo "|              Do you have SSL pre-generated?             |"
echo "|                                                         |"
echo '|       Please say "y" to continue, and "n" to stop       |'
echo "|---------------------------------------------------------|"

read ssl_yes

if [ "$ssl_yes" = "n" ] || [ "$ssl_yes" = "no" ]; then

  echo "|---------------------------------------------------------|"
  echo "|    Exiting Apache2 configuration. You will need SSL.    |"
  echo "|     You can get SSL from CloudFlare or LetsEncrypt!     |"
  echo "|---------------------------------------------------------|"

  sleep 3

  exit

fi
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Confirming SSL location
#
echo "|---------------------------------------------------------|"
echo "|             This Configuration requires SSL!            |"
echo "|                                                         |"
echo '|      Please say below what your "pem" file is called!   |'
echo "|              It must be in this Directory!              |"
echo "|                                                         |"
echo "|                ex: mrmagicpie.xyz.pem                   |"
echo "|---------------------------------------------------------|"
echo " "

read pem

echo "|---------------------------------------------------------|"
echo "|             This Configuration requires SSL!            |"
echo "|                                                         |"
echo '|      Please say below what your "key" file is called!   |'
echo "|              It must be in this Directory!              |"
echo "|                                                         |"
echo "|                ex: mrmagicpie.xyz.key                   |"
echo "|---------------------------------------------------------|"
echo " "

read key

echo "|---------------------------------------------------------|"
echo '|            Please confirm this information:             |'
echo "|                                                         |"
echo "| Your pem file is located at: $dir/$pem           |"
echo "| Your key file is located at: $dir/$key           |"
echo "|                                                         |"
echo '|       Please say "y" to continue, and "n" to stop       |'
echo "|---------------------------------------------------------|"
echo " "

read ssl_dir

if [ "$ssl_dir" = "n" ] || [ "$ssl_dir" = "no" ]; then

  echo "|---------------------------------------------------------|"
  echo "|     Please confirm your SSL location, and try again.    |"
  echo "|---------------------------------------------------------|"

  sleep 3

  exit

fi
systemctl start apache2
systemctl enable apache2
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# PHP install
#
if ! [ -x $(yum list installed|grep 'php') ]; then

  echo "|---------------------------------------------------------|"
  echo "|                       Install PHP?                      |"
  echo "|            We recommend having PHP Installed!           |"
  echo "|                   https://www.php.net/                  |"
  echo "|                                                         |"
  echo '|           Please say "y" for yes, "n" for no.           |'
  echo "|---------------------------------------------------------|"
  echo " "

  read phpp

  if [ "$phpp" = "n" ] || [ "$phpp" = "no" ]; then

    echo "|---------------------------------------------------------|"
    echo "|                 We will not install PHP                 |"
    echo "|---------------------------------------------------------|"

    php="n"

    sleep 1

  else; then

    echo "|---------------------------------------------------------|"
    echo "|                     Installing PHP                      |"
    echo "|---------------------------------------------------------|"

    php="y"

    sleep 1

    yum install php

  fi

fi
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Domain Conf
#

# Config File
domain_conf="/etc/httpd/conf.d/$domain.conf"
touch $domain_conf

# Document Root
mkdir "/var/www/$domain"
mkdir "/var/www/$domain/logs"
mkdir "/var/www/$domain/website"

# SSL
mkdir "/ssl"
mv "./$pem" "/ssl/$domain.pem"
mv "./$key" "/ssl/$domain.key"

echo """#
#
# $domain Apache2 Configuration File
# https://Apache.Mrmagicpie.xyz
#
#

# Root No-SSL

<VirtualHost *:80>

        ServerName $domain
        ServerAlias www.$domain

        Redirect 302 / https://$domain
        ErrorLog /var/www/$domain/logs/error.log
        CustomLog /var/www/$domain/logs/access.log combined

</VirtualHost>

# Root SSL

<VirtualHost *:443>

        ServerName $domain
        ServerAlias www.$domain

        DocumentRoot /var/www/$domain/website
        ErrorLog /var/www/$domain/logs/error.log
        CustomLog /var/www/$domain/logs/access.log combined

        SSLEngine on
        SSLCertificateFile /ssl/$domain.pem
        SSLCertificateKeyFile /ssl/$domain.key

</VirtualHost>

# Wildcard

<VirtualHost *:80>

        ServerName wildcard.$domain
        ServerAlias *.$domain

        Redirect 302 / https://$domain
        ErrorLog /var/www/$domain/logs/error.log
        CustomLog /var/www/$domain/logs/access.log combined

</VirtualHost>
""" >> "$domain_conf"

# Apache Configuration
a2ensite $domain

systemctl restart apache2

echo """
|---------------------------------------------------------|
|The Apache2 Configuration is now complete! You may have  |
|to wait for DNS to update before using your site.        |
|                                                         |
|Upload your Website files to:                            |
|       /var/www/$domain/website                 |
|To begin using Apache2.                                  |
|                                                         |
| Report issues or contribute here:                       |
|     https://github.com/Mrmagicpie/Apache2-Centos        |
|---------------------------------------------------------|
"""

sleep 3

exit

#                       Mrmagicpie (c) 2020
#
#                       Apache.Mrmagicpie.xyz
#
#                GitHub.com/Mrmagicpie/Apache2-Centos