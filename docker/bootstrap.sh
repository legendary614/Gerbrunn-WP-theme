#!/bin/sh
service apache2 start
a2enmod rewrite
service apache2 restart

rm /var/www/html/index.html
chown -R root:www-data /var/www
chmod -R 0775 /var/www

find /var/lib/mysql -type f -exec touch {} \; && service mysql start
sleep 2

mysql < /var/www/builddir/init_database.sql
sleep 1
mysql < /var/www/builddir/database.sql

service proftpd start

adduser ftpuser --shell /bin/false --home /var/www --disabled-password --gecos ""
echo ftpuser:ftpuser1 | chpasswd

usermod -a -G www-data ftpuser
usermod -a -G ftpuser ftpuser

/bin/bash
