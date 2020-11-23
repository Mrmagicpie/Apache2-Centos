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

   echo "|------------------------------------|"
   echo "|You are not root! Please use sudo or|"
   echo "|     root to run this script!       |"
   echo "|                                    |"
   echo "|   Exiting Apache2 Configuration!   |"
   echo "|------------------------------------|"

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
# Starting the install
#
echo "|---------------------------------------------------------|"
echo "|Welcome to the Apache2 Basic Install. Please make sure   |"
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
# Asking if they want to install with their domain
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
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Apache install
#
echo "|---------------------------------------------------------|"
echo "|                     Install Apache2?                    |"
echo "|                                                         | "
echo '|           Please say "y" for yes, "n" for no.           |'
echo "|---------------------------------------------------------|"
echo " "

read apache

if [ "$apache" = "n" ] || [ "$apache" = "no" ]; then

  echo "|---------------------------------------------------------|"
	echo "|              Exiting Apache2 configuration.             |"
  echo "|                                                         |"
  echo "|        You need Apache2 to run an Apache2 server        |"
	echo "|---------------------------------------------------------|"

	sleep 3

  exit

fi

echo "|---------------------------------------------------------|"
echo "|                  Installing Apache2                     |"
echo "|---------------------------------------------------------|"

sleep 1

yum install apache2
systemctl start apache2
systemctl enable apache2
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# PHP install
#
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
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Firewall setup
#
echo "|---------------------------------------------------------|"
echo "|                    Setup the Firewall?                  |"
echo "|     If you do not use this, you will have to manually   |"
echo "|         the firewall to allow HTTP/HTTPS traffic        |"
echo "|                                                         |"
echo '|           Please say "y" for yes, "n" for no.           |'
echo "|---------------------------------------------------------|"
echo " "

read firewall

if [ "$firewall" = "n" ] || [ "$firewall" = "no" ]; then

  echo "|---------------------------------------------------------|"
	echo "|              We will not setup the Firewall             |"
	echo "|---------------------------------------------------------|"

	sleep 1

else; then

  echo "|---------------------------------------------------------|"
  echo "|                 Setting up the Firewall                 |"
  echo "|---------------------------------------------------------|"

  sleep 1

  yum install firewalld
  systemctl start firewalld
  systemctl enable firewalld

  firewall-cmd --zone=public --add-service=http --permanent
  firewall-cmd --zone=public --add-service=https --permanent
  firewall-cmd --reload

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
a2enmod ssl
a2enmod rewrite
a2ensite $domain
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# .htaccess files
#
a2conf="/etc/httpd/conf/httpd.conf"

echo "|---------------------------------------------------------|"
echo '|      Would you like Apache Access Files(.htaccess)?     |'
echo "|                                                         |"
echo '|        Please say "y" for yes, and "n" to stop          |'
echo "|---------------------------------------------------------|"

read htaccess

if [ "$htaccess" = "n" ] || [ "$htaccess" = "no" ]; then

	echo "|---------------------------------------------------------|"
	echo "| We will not configure Apache Access Files(.htaccess)!   |"
	echo "|                                                         |"
	echo "| The Apache2 Installation is now complete. If this didn't|"
	echo "|            work for you, please let us know!!           |"
	echo "|                                                         |"
	echo "|          https://github.com/Mrmagicpie/Apache2          |"
	echo "|---------------------------------------------------------|"

  if [ "$php" = "y" ]; then

    echo "DirectoryIndex index.php index.html index.htm index.xml" >> "$a2conf"

  fi

	sleep 1

	exit

fi

mv "$a2conf" "/etc/httpd/conf/httpd.conf.txt"
touch "$a2conf"

echo '''#
#
# Main Apache2 Configuration
# https://Apache.Mrmagicpie.xyz
#
#

# Timeout

Timeout 300
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 5

# Logs

ErrorLog ${APACHE_LOG_DIR}/error.log
LogLevel warn
LogFormat "%v:%p %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %O" common
LogFormat "%{Referer}i -> %U" referer

# Mod/Site Includes

IncludeOptional mods-enabled/*.load
IncludeOptional mods-enabled/*.conf
IncludeOptional conf-enabled/*.conf
IncludeOptional sites-enabled/*.conf
Include ports.conf

# Directory Access

<Directory /var/www/>
	Options Indexes FollowSymLinks
	AllowOverride All
	Require all granted
</Directory>
<Directory /usr/share>
	AllowOverride None
	Require all granted
</Directory>
<Directory />
	Options FollowSymLinks
	AllowOverride None
	Require all denied
</Directory>
<FilesMatch "^\.ht">
	Require all denied
</FilesMatch>

# Other Settings

User ${APACHE_RUN_USER}
Group ${APACHE_RUN_GROUP}
HostnameLookups Off
AccessFileName .htaccess
DefaultRuntimeDir ${APACHE_RUN_DIR}
PidFile ${APACHE_PID_FILE}
  ''' >> $a2conf

if [ "$php" = "n" ]; then

  echo '''
#                       Mrmagicpie (c) 2020
#
#                       Apache.Mrmagicpie.xyz
#
#                   GitHub.com/Mrmagicpie/Apache2''' >> "$a2conf"

else; then

  echo '''DirectoryIndex index.php index.html index.htm index.xml

#                       Mrmagicpie (c) 2020
#
#                       Apache.Mrmagicpie.xyz
#
#                   GitHub.com/Mrmagicpie/Apache2''' >> "$a2conf"

fi

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