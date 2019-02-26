# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://hub.docker.com/_/ubuntu/

#How to build
#sudo docker build -f ubuntu18_apache_php72.Dockerfile . -t ubuntu18_apache_php72

#How use iterative mode
#sudo docker exec -it ubuntu18_apache_php72:16.04 /bin/bash

#How use iterative mode image
#sudo docker run -it ubuntu18_apache_php72:16.04 /bin/bash           #only bash
#sudo docker run -p 80:80 -it ubuntu18_apache_php72:16.04 /bin/bash
#sudo docker run -d -p 80:80 ubuntu18_apache_php72:16.04

#######################################
FROM php:7.3-apache 
LABEL maintainer="bjverde@yahoo.com.br"
EXPOSE 80

## ------------- Install Apache2 + PHP 7.3  ------------------
#PHP Modules : curl, date, dom, fileinfo, filter, ftp, hash, iconv, json, libxml, libxml
#PHP Modules : ,mbstring, openssl, PDO, pdo_sqlite, Phar, posix, SimpleXML


ENV DEBIAN_FRONTEND noninteractive

#Install facilitators
RUN apt-get update && apt-get install -y locate mlocate curl nano wget gnupg apt-utils

#PHP PDO MySQL
#RUN docker-php-ext-install pdo_mysql mysqli

#PHP PDO PostgreSql
#RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo_pgsql

#PHP Zip
#RUN apt-get install -y zlib1g-dev && docker-php-ext-install zip


## ------------- Add-ons ------------------
#Install GIT
#RUN apt-get -y install -y git-core

#PHP Install Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#PHP Install PHPUnit
#https://phpunit.de/getting-started/phpunit-7.html
#RUN wget -O /usr/local/bin/phpunit-7.phar https://phar.phpunit.de/phpunit-7.phar; chmod +x /usr/local/bin/phpunit-7.phar; \
#ln -s /usr/local/bin/phpunit-7.phar /usr/local/bin/phpunit


## ------------- LDAP ------------------
#PHP Install LDAP
#RUN apt-get -y php-ldap

#Apache2 enebla LDAP
#RUN sudo a2enmod authnz_ldap
#RUN sudo a2enmod ldap


##------------ Install Precondition for Drive SQL Server -----------
# The installation of Drive SQL Server for PHP on Linux is not so simple.
# You should combine the PHP version with Drive PDO version with the ODBC version
# with the SQL Server version. Complete information on:
# https://docs.microsoft.com/pt-br/sql/connect/php/system-requirements-for-the-php-sql-driver?view=sql-server-2017
#
# This installation works with Ubuntu 16.04, PHP 7.0.32, Drive PDO_SQLSRV 4.3, MS ODBC 12, MS SQL Server 2008 R2 or higher

#RUN apt-get -y -q install php-pear php-dev 
#RUN apt-get -y install mcrypt php-mcrypt

#RUN apt-get install libcurl3-openssl-dev

ENV ACCEPT_EULA=Y

RUN curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl -s https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get install -y -q --no-install-recommends \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && apt-get update

# install MSODBC 17
RUN apt-get -y -q --no-install-recommends install msodbcsql17 mssql-tools

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN exec bash

#RUN apt-get -y install unixodbc unixodbc-dev
#RUN apt-get -y install gcc g++ make autoconf libc-dev pkg-config


##------------ Install Drive 5.2 for SQL Server -----------
# List version drive PDO https://pecl.php.net/package/pdo_sqlsrv
# Install Drive: https://docs.microsoft.com/pt-br/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-2017

RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv

#For PHP CLI
#RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
#RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini

#For PHP WEB
#RUN echo "extension=pdo_sqlsrv.so" >> /etc/php/7.0/apache2/conf.d/30-pdo_sqlsrv.ini
#RUN echo "extension=sqlsrv.so" >> /etc/php/7.0/apache2/conf.d/20-sqlsrv.ini



## ------------- Finishing ------------------
RUN apt-get clean

#Creating index of files
RUN updatedb
