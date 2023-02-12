# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://hub.docker.com/_/debian

#How to build
#sudo docker build -f debian10_apache_php81_mssql.Dockerfile . -t debian10_apache_php81_mssql

#How use iterative mode
#sudo docker exec -it debian10_apache_php81_mssql:last /bin/bash

#How use iterative mode image
#sudo docker run -it debian10_apache_php81_mssql:last /bin/bash           #only bash
#sudo docker run -p 80:80 -it debian10_apache_php81_mssql:last /bin/bash
#sudo docker run -d -p 80:80 debian10_apache_php81_mssql:last

#Stop all containers
#sudo docker stop $(sudo docker ps -a -q)

#Remove all containers
#sudo docker rm $(sudo docker ps -a -q)

#######################################
FROM debian:11
LABEL maintainer="bjverde@yahoo.com.br"

ENV DEBIAN_FRONTEND noninteractive

# Set default environment variables
ENV TIMEZONE America/Sao_Paulo

#Install update
RUN apt-get update
RUN apt-get upgrade -y

#Install facilitators
RUN apt-get -y install locate mlocate wget apt-utils curl apt-transport-https lsb-release \
             ca-certificates software-properties-common zip unzip vim rpl

# Fix ‘add-apt-repository command not found’
RUN apt-get install software-properties-common

## ------------- Install Apache2 + PHP 8.1  x86_64 ------------------
#Thread Safety 	disabled 
#PHP Modules : calendar,Core,ctype,date,exif,fileinfo,filter,ftp,gettext,hash,iconv,json,libxml
#PHP Modules : ,openssl,pcntl,pcre,PDO,Phar,posix,readline,Reflection,session,shmop,sockets,SPL,standard
#PHP Modules : ,sysvmsg,sysvsem,sysvshm,tokenizer,Zend OPcache,zlib

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

#Install update
RUN apt-get update


# Set Timezone
RUN ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && apt-get update \
    && apt-get install -y --no-install-recommends tzdata \
    && dpkg-reconfigure --frontend noninteractive tzdata

#intall Apache + PHP
RUN apt-get -y install apache2 libapache2-mod-php8.1 php8.1 php8.1-cli php8.1-common php8.1-opcache

#PHP Install CURl
RUN apt-get -y install curl php8.1-curl

#PHP Intall DOM, Json, XML e Zip
RUN apt-get -y install php8.1-dom php8.1-xml php8.1-zip php8.1-soap php8.1-intl php8.1-xsl

#PHP Install MbString
RUN apt-get -y install php8.1-mbstring

#PHP Install GD
RUN apt-get -y install php8.1-gd

#PHP Install PDO SqLite
RUN apt-get -y install php8.1-pdo php8.1-pdo-sqlite php8.1-sqlite3

#PHP Install PDO MySQL
RUN apt-get -y install php8.1-pdo php8.1-pdo-mysql php8.1-mysql 

#PHP Install PDO PostGress
RUN apt-get -y install php8.1-pdo php8.1-pgsql

## -------- Config Apache ----------------
RUN a2dismod mpm_event
RUN a2dismod mpm_worker
RUN a2enmod  mpm_prefork
RUN a2enmod  rewrite
RUN a2enmod  php8.1

# Enable .htaccess reading
RUN LANG="en_US.UTF-8" rpl "AllowOverride None" "AllowOverride All" /etc/apache2/apache2.conf

## ------------- LDAP ------------------
#PHP Install LDAP
RUN apt-get -y install php8.1-ldap

#Apache2 enebla LDAP
RUN a2enmod authnz_ldap
RUN a2enmod ldap

## ------------- Add-ons ------------------
#Install GIT
RUN apt-get -y install -y git-core

#PHP Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#PHP Install PHPUnit
#https://phpunit.de/announcements/phpunit-9.html
RUN wget -O /usr/local/bin/phpunit-9.phar https://phar.phpunit.de/phpunit-9.phar; chmod +x /usr/local/bin/phpunit-9.phar; \
ln -s /usr/local/bin/phpunit-9.phar /usr/local/bin/phpunit

## ------------- X-DEBUG 3.X ------------------
#PHP Install X-debug
#RUN apt-get -y install php8.1-xdebug

#PHP X-Degub enable remote debug
#RUN echo "xdebug.start_with_request=yes" >> /etc/php/8.1/mods-available/xdebug.ini
#RUN echo "xdebug.mode = develop,coverage,debug" >> /etc/php/8.1/mods-available/xdebug.ini

#PHP X-Degub enable log
#RUN echo "xdebug.log=/var/log/apache2/xdebug.log" >> /etc/php/8.1/mods-available/xdebug.ini


##------------ Install Precondition for Drive SQL Server -----------
# The installation of Drive SQL Server for PHP on Linux is not so simple.
# You should combine the PHP version with Drive PDO version with the ODBC version
# with the SQL Server version. Complete information on:
# https://docs.microsoft.com/pt-br/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-2017#installing-on-debian
#
# This installation works with Debian 11, PHP 8.1, Drive PDO_SQLSRV 5.10.0, Microsoft ODBC Driver 17 for SQL Server , MS SQL Server 2008 R2 or higher

RUN apt-get -y install php8.1-dev php8.1-xml php8.1-intl

ENV ACCEPT_EULA=Y

RUN curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl -s https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

# install MS ODBC 18
# https://docs.microsoft.com/pt-br/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017#debian18
RUN apt-get -y install msodbcsql18 mssql-tools18

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN exec bash

RUN apt-get -y install unixodbc unixodbc-dev
RUN apt-get -y install gcc g++ make autoconf libc-dev pkg-config

##------------ Install Drive 5.10.0 for SQL Server -----------
# List version drive PDO https://pecl.php.net/package/pdo_sqlsrv
# Install Drive: https://docs.microsoft.com/pt-br/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-2017
RUN apt-get install php-pear
RUN pecl -vvv install sqlsrv-5.10.1
RUN pecl -vvv install pdo_sqlsrv-5.10.1

#For PHP CLI
RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini

#For PHP WEB
RUN echo "extension=pdo_sqlsrv.so" >> /etc/php/8.1/apache2/conf.d/30-pdo_sqlsrv.ini
RUN echo "extension=sqlsrv.so" >> /etc/php/8.1/apache2/conf.d/20-sqlsrv.ini

#Config Apache
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork
RUN a2enmod php8.1

#PHP Install Mongodb ext
#RUN pecl install mongodb
RUN apt-get -y install php8.1-mongodb

##------------ FIX problem OpenSLL with Last version SqlServer -----------
## https://askubuntu.com/questions/1102803/how-to-upgrade-openssl-1-1-0-to-1-1-1-in-ubuntu-18-04#
## https://stackoverflow.com/questions/41887754/why-apt-get-install-openssl-did-not-install-last-version-of-openssl
## -----------

#RUN apt-get install pkg-config 
#RUN wget -c https://www.openssl.org/source/openssl-1.1.1g.tar.gz -P /tmp
#RUN tar -zxf /tmp/openssl-1.1.1g.tar.gz -C /tmp
#RUN /tmp/openssl-1.1.1g/config
#RUN make
#RUN make test
#RUN mv /usr/bin/openssl ~/tmp
#RUN make install
#RUN ln -s /usr/local/bin/openssl /usr/bin/openssl


## ------------- Finishing ------------------
RUN apt-get clean

#Creating index of files
RUN updatedb

EXPOSE 80
EXPOSE 443
CMD apachectl -D FOREGROUND