# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://hub.docker.com/_/debian

#How to build
#sudo docker build -f debian10_apache_php74.Dockerfile . -t debian10_apache_php8

#How use iterative mode
#sudo docker exec -it debian10_apache_php74:last /bin/bash

#How use iterative mode image
#sudo docker run -it debian10_apache_php74:last /bin/bash           #only bash
#sudo docker run -p 80:80 -it debian10_apache_php74:last /bin/bash
#sudo docker run -d -p 80:80 debian10_apache_php74:last

#Stop all containers
#sudo docker stop $(sudo docker ps -a -q)

#Remove all containers
#sudo docker rm $(sudo docker ps -a -q)

#######################################
FROM debian:10
LABEL maintainer="bjverde@yahoo.com.br"

ENV DEBIAN_FRONTEND noninteractive

# Set default environment variables
ENV TIMEZONE America/Sao_Paulo

#Install update
RUN apt-get update
RUN apt-get upgrade -y

#Install facilitators
RUN apt-get -y install locate mlocate wget apt-utils curl apt-transport-https lsb-release \
    ca-certificates software-properties-common zip unzip vim rpl apt-utils

# Fix ‘add-apt-repository command not found’
RUN apt-get install software-properties-common

## ------------- Install Apache2 + PHP 7.4  x86_64 ------------------
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
RUN apt-get -y install apache2 php7.4 libapache2-mod-php7.4 php7.4-cli php7.4-common php7.4-opcache

#PHP Install CURl
RUN apt-get -y install curl php7.4-curl

#PHP Intall DOM, Json, XML e Zip
RUN apt-get -y install php7.4-dom php7.4-xml php7.4-zip php7.4-soap php7.4-intl php7.4-xsl

#PHP Install MbString
RUN apt-get -y install php7.4-mbstring

#PHP Install GD
RUN apt-get -y install php7.4-gd

#PHP Install PDO SqLite
RUN apt-get -y install php7.4-pdo php7.4-pdo-sqlite php7.4-sqlite3

#PHP Install PDO MySQL
RUN apt-get -y install php7.4-pdo php7.4-pdo-mysql php7.4-mysql 

#PHP Install PDO PostGress
RUN apt-get -y install php7.4-pdo php7.4-pgsql

#PHP Install Mongodb ext
#RUN apt-get -y install php7.4-mongodb

## -------- Config Apache ----------------
RUN a2dismod mpm_event
RUN a2dismod mpm_worker
RUN a2enmod  mpm_prefork
RUN a2enmod  rewrite
RUN a2enmod  php7.4

# Enable .htaccess reading
RUN LANG="en_US.UTF-8" rpl "AllowOverride None" "AllowOverride All" /etc/apache2/apache2.conf

## ------------- LDAP ------------------
#PHP Install LDAP
RUN apt-get -y install php7.4-ldap

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


## ------------- Config PHP para Adianti ------------------
# Set PHP custom settings
RUN echo "\n# Custom settings"                                    >> /etc/php/7.4/apache2/php.ini \
    && echo "memory_limit = 256M"                                 >> /etc/php/7.4/apache2/php.ini \
    && echo "max_execution_time = 120"                            >> /etc/php/7.4/apache2/php.ini \
    && echo "file_uploads = On"                                   >> /etc/php/7.4/apache2/php.ini \
    && echo "post_max_size = 100M"                                >> /etc/php/7.4/apache2/php.ini \
    && echo "upload_max_filesize = 100M"                          >> /etc/php/7.4/apache2/php.ini \
    && echo "session.gc_maxlifetime = 14000"                      >> /etc/php/7.4/apache2/php.ini \
    && echo "display_errors = On"                                 >> /etc/php/7.4/apache2/php.ini \
    && echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /etc/php/7.4/apache2/php.ini

# Set PHP security settings
RUN echo "\n# Security settings"                    >> /etc/php/7.4/apache2/php.ini \
    && echo "session.name = CUSTOMSESSID"           >> /etc/php/7.4/apache2/php.ini \
    && echo "session.use_only_cookies = 1"          >> /etc/php/7.4/apache2/php.ini \
    && echo "session.cookie_httponly = true"        >> /etc/php/7.4/apache2/php.ini \
    && echo "session.use_trans_sid = 0"             >> /etc/php/7.4/apache2/php.ini \
    && echo "session.entropy_file = /dev/urandom"   >> /etc/php/7.4/apache2/php.ini \
    && echo "session.entropy_length = 32"           >> /etc/php/7.4/apache2/php.ini


## ------------- X-DEBUG 3.X ------------------
#PHP Install X-debug
#RUN apt-get -y install php7.4-xdebug

#PHP X-Degub enable remote debug
#RUN echo "xdebug.start_with_request=yes" >> /etc/php/7.4/mods-available/xdebug.ini
#RUN echo "xdebug.mode = develop,coverage,debug" >> /etc/php/7.4/mods-available/xdebug.ini

#PHP X-Degub enable log
#RUN echo "xdebug.log=/var/log/apache2/xdebug.log" >> /etc/php/7.4/mods-available/xdebug.ini


##------------ Install Precondition for Drive SQL Server -----------
# The installation of Drive SQL Server for PHP on Linux is not so simple.
# You should combine the PHP version with Drive PDO version with the ODBC version
# with the SQL Server version. Complete information on:
# https://docs.microsoft.com/pt-br/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-2017#installing-the-drivers-on-debian-8-and-9
#
# This installation works with Debian 10, PHP 7.4, Drive PDO_SQLSRV 5.6.1, Microsoft ODBC Driver 17 for SQL Server , MS SQL Server 2008 R2 or higher

RUN apt-get -y install php7.4-dev php7.4-xml php7.4-intl

ENV ACCEPT_EULA=Y

RUN curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl -s https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

# install MSODBC 17
RUN apt-get -y --no-install-recommends install msodbcsql17 mssql-tools

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN exec bash

RUN apt-get -y install unixodbc unixodbc-dev
RUN apt-get -y install gcc g++ make autoconf libc-dev pkg-config


##------------ Install Drive 5.9.0 for SQL Server -----------
# List version drive PDO https://pecl.php.net/package/pdo_sqlsrv
# Install Drive: https://docs.microsoft.com/pt-br/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-2017

RUN pecl install sqlsrv-5.9.0
RUN pecl install pdo_sqlsrv-5.9.0

#For PHP CLI
RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini

#For PHP WEB
RUN echo "extension=pdo_sqlsrv.so" >> /etc/php/7.4/apache2/conf.d/30-pdo_sqlsrv.ini
RUN echo "extension=sqlsrv.so" >> /etc/php/7.4/apache2/conf.d/20-sqlsrv.ini

#RUN phpenmod -v 7.3 sqlsrv pdo_sqlsrv
#RUN apt-get install libapache2-mod-php7.3 apache2
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork
RUN a2enmod php7.4

## ------------- Finishing ------------------
RUN apt-get clean

#Creating index of files
RUN updatedb

EXPOSE 80
CMD apachectl -D FOREGROUND