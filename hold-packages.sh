#!/bin/bash

# Hold PHP packages
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;")
echo "Detected PHP version: $PHP_VERSION"
for PACKAGE in php$PHP_VERSION php$PHP_VERSION-cli php$PHP_VERSION-fpm php$PHP_VERSION-common php$PHP_VERSION-opcache; do
    echo "Holding PHP package: $PACKAGE"
    sudo apt-mark hold $PACKAGE
done

# Hold MySQL packages
MYSQL_VERSION=$(mysql --version | grep -oP 'Distrib \K[0-9]+\.[0-9]+')
echo "Detected MySQL version: $MYSQL_VERSION"
for PACKAGE in mysql-server-$MYSQL_VERSION mysql-client-$MYSQL_VERSION mysql-common-$MYSQL_VERSION; do
    echo "Holding MySQL package: $PACKAGE"
    sudo apt-mark hold $PACKAGE
done

# Verify held packages
echo "Packages currently on hold:"
apt-mark showhold
