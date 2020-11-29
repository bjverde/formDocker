# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://hub.docker.com/_/debian

#How to build
#sudo docker build -f debian10_apache_php8.Dockerfile . -t debian10_apache_php8

#How use iterative mode
#sudo docker exec -it debian10_apache_php8:last /bin/bash

#How use iterative mode image
#sudo docker run -it debian10_apache_php8:last /bin/bash           #only bash
#sudo docker run -p 80:80 -it debian10_apache_php8:last /bin/bash
#sudo docker run -d -p 80:80 debian10_apache_php8:last

#Stop all containers
#sudo docker stop $(sudo docker ps -a -q)

#Remove all containers
#sudo docker rm $(sudo docker ps -a -q)

#######################################
FROM debian:10
LABEL maintainer="bjverde@yahoo.com.br"

ENV DEBIAN_FRONTEND noninteractive

#Install update
RUN apt-get update
RUN apt-get upgrade -y

#Install facilitators
RUN apt-get -y install locate mlocate wget apt-utils curl apt-transport-https lsb-release ca-certificates 

## ------------- Install Apache2 + PHP 7.3  x86_64 ------------------
#Thread Safety 	disabled 
#PHP Modules : calendar,Core,ctype,date,exif,fileinfo,filter,ftp,gettext,hash,iconv,json,libxml
#PHP Modules : ,openssl,pcntl,pcre,PDO,Phar,posix,readline,Reflection,session,shmop,sockets,SPL,standard
#PHP Modules : ,sysvmsg,sysvsem,sysvshm,tokenizer,Zend OPcache,zlib

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

#Install update
RUN apt-get update

RUN apt-get -y install php8.0 php8.0-cli php8.0-common php8.0-opcache

#PHP Install CURl
RUN apt-get -y install curl php8.0-curl

#PHP Intall DOM, Json, XML e Zip
RUN apt-get -y install php8.0-dom php8.0-xml php8.0-zip

#PHP Install MbString
RUN apt-get -y install php8.0-mbstring

#PHP Install PDO SqLite
RUN apt-get -y install php8.0-pdo php8.0-pdo-sqlite php8.0-sqlite3

#PHP Install PDO MySQL
RUN apt-get -y install php8.0-pdo php8.0-pdo-mysql php8.0-mysql 

#PHP Install PDO PostGress
RUN apt-get -y install php8.0-pdo php8.0-pgsql

#PHP Install X-debug
RUN apt-get -y install php8.0-xdebug


RUN apt-get -y -q install apache2 php8.0 libapache2-mod-php8.0

## ------------- Add-ons ------------------
#Install GIT
RUN apt-get -y install -y git-core

#PHP Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#PHP Install PHPUnit
#https://phpunit.de/announcements/phpunit-9.html
RUN wget -O /usr/local/bin/phpunit-9.phar https://phar.phpunit.de/phpunit-9.phar; chmod +x /usr/local/bin/phpunit-9.phar; \
ln -s /usr/local/bin/phpunit-9.phar /usr/local/bin/phpunit


## ------------- LDAP ------------------
#PHP Install LDAP
RUN apt-get -y install php8.0-ldap

#Apache2 enebla LDAP
RUN a2enmod authnz_ldap
RUN a2enmod ldap



## ------------- Finishing ------------------
RUN apt-get clean

#Creating index of files
RUN updatedb

EXPOSE 80
CMD apachectl -D FOREGROUND
