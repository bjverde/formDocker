# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://hub.docker.com/_/debian

#How to build
#sudo docker build -f debian9_apache_php73.Dockerfile . -t debian9_apache_php73

#How use iterative mode
#sudo docker exec -it debian9_apache_php73:last /bin/bash

#How use iterative mode image
#sudo docker run -it debian9_apache_php73:last /bin/bash           #only bash
#sudo docker run -p 80:80 -it debian9_apache_php73:last /bin/bash
#sudo docker run -d -p 80:80 debian9_apache_php73:last

#Stop all containers
#sudo docker stop $(sudo docker ps -a -q)

#Remove all containers
#sudo docker rm $(sudo docker ps -a -q)

#######################################
FROM debian:9
LABEL maintainer="bjverde@yahoo.com.br"

ENV DEBIAN_FRONTEND noninteractive

#Install update
RUN apt-get update

#Install facilitators
RUN apt-get -y install locate mlocate wget apt-utils curl apt-transport-https lsb-release ca-certificates 

## ------------- Install Apache2 + PHP 7.3  x86_64 ------------------
#Thread Safety 	disabled 
#PHP Modules : calendar,Core,ctype,date,exif,fileinfo,filter,ftp,gettext,hash,iconv,json,libxml
#PHP Modules : ,openssl,pcntl,pcre,PDO,Phar,posix,readline,Reflection,session,shmop,sockets,SPL,standard
#PHP Modules : ,sysvmsg,sysvsem,sysvshm,tokenizer,Zend OPcache,zlib

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.3.list

RUN apt-get update
RUN apt-get -y install php7.3 php7.3-cli php7.3-common php7.3-opcache

#PHP Install CURl
RUN apt-get -y install curl php7.3-curl

#PHP Intall DOM, Json, XML e Zip
RUN apt-get -y install php7.3-dom php7.3-json php7.3-xml php7.3-zip

#PHP Install MbString
RUN apt-get -y install php7.3-mbstring

#PHP Install PDO SqLite
RUN apt-get -y install php7.3-pdo php7.3-pdo-sqlite php7.3-sqlite3

#PHP Install PDO MySQL
RUN apt-get -y install php7.3-pdo php7.3-pdo-mysql php7.3-mysql 

#PHP Install PDO PostGress
RUN apt-get -y install php7.3-pdo php7.3-pgsql

#PHP Install X-debug
#RUN apt-get -y install php-xdebug


RUN apt-get -y -q install apache2 php libapache2-mod-php7.3

## ------------- Add-ons ------------------
#Install GIT
#RUN apt-get -y install -y git-core

#PHP Install Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#PHP Install PHPUnit
#https://phpunit.de/getting-started/phpunit-8.html
#RUN wget -O /usr/local/bin/phpunit-8.phar https://phar.phpunit.de/phpunit-8.phar; chmod +x /usr/local/bin/phpunit-8.phar; \
#ln -s /usr/local/bin/phpunit-8.phar /usr/local/bin/phpunit


## ------------- LDAP ------------------
#RUN apt-get -y install php7.3-ldap
#PHP Install LDAP
#RUN apt-get -y php-ldap

#Apache2 enebla LDAP
#RUN sudo a2enmod authnz_ldap
#RUN sudo a2enmod ldap


##------------ Install Precondition for Drive SQL Server -----------
# The installation of Drive SQL Server for PHP on Linux is not so simple.
# You should combine the PHP version with Drive PDO version with the ODBC version
# with the SQL Server version. Complete information on:
# https://docs.microsoft.com/pt-br/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-2017#installing-the-drivers-on-debian-8-and-9
#
# This installation works with Debian 9, PHP 7.3, Drive PDO_SQLSRV , Microsoft ODBC Driver 17 for SQL Server , MS SQL Server 2008 R2 or higher

RUN apt-get -y install php7.3-dev 

ENV ACCEPT_EULA=Y

RUN curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl -s https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get install -y --no-install-recommends \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && apt-get update

# install MSODBC 17
RUN apt-get -y --no-install-recommends install msodbcsql17 mssql-tools

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN exec bash

RUN apt-get -y install unixodbc unixodbc-dev
RUN apt-get -y install gcc g++ make autoconf libc-dev pkg-config


##------------ Install Drive 5.6.1 for SQL Server -----------
# List version drive PDO https://pecl.php.net/package/pdo_sqlsrv
# Install Drive: https://docs.microsoft.com/pt-br/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-2017

RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv

#For PHP CLI
RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini

#For PHP WEB
RUN echo "extension=pdo_sqlsrv.so" >> /etc/php/7.3/apache2/conf.d/30-pdo_sqlsrv.ini
RUN echo "extension=sqlsrv.so" >> /etc/php/7.3/apache2/conf.d/20-sqlsrv.ini

RUN phpenmod sqlsrv pdo_sqlsrv
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork
RUN a2enmod php7.3


## ------------- Finishing ------------------
RUN apt-get clean

#Creating index of files
RUN updatedb

EXPOSE 80
CMD apachectl -D FOREGROUND