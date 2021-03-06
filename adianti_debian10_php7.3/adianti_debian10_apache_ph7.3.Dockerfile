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

# Set default environment variables
ENV TIMEZONE America/Sao_Paulo

#Install update
RUN apt-get update
RUN apt-get upgrade -y

#Install facilitators
RUN apt-get -y install locate mlocate wget apt-utils curl apt-transport-https lsb-release \
    ca-certificates software-properties-common zip unzip vim rpl apt-utils

## ------------- Install Apache2 + PHP 7.3  x86_64 ------------------
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
RUN apt-get -y install apache2 php7.3 libapache2-mod-php7.3 php7.3-cli php7.3-common php7.3-opcache

#PHP Install CURl
RUN apt-get -y install curl php7.3-curl

#PHP Intall DOM, Json, XML e Zip
RUN apt-get -y install php7.3-dom php7.3-xml php7.3-zip php7.3-gd php7.3-soap php7.3-intl php7.3-xsl

#PHP Install MbString
RUN apt-get -y install php7.3-mbstring

#PHP Install PDO SqLite
RUN apt-get -y install php7.3-pdo php7.3-pdo-sqlite php7.3-sqlite3

#PHP Install PDO MySQL
RUN apt-get -y install php7.3-pdo php7.3-pdo-mysql php7.3-mysql 

#PHP Install PDO PostGress
RUN apt-get -y install php7.3-pdo php7.3-pgsql


## -------- Config Apache ----------------
RUN a2dismod mpm_event
RUN a2dismod mpm_worker
RUN a2enmod  mpm_prefork
RUN a2enmod  rewrite
RUN a2enmod  php7.3

# Enable .htaccess reading
RUN LANG="en_US.UTF-8" rpl "AllowOverride None" "AllowOverride All" /etc/apache2/apache2.conf

## ------------- LDAP ------------------
#PHP Install LDAP
RUN apt-get -y install php7.3-ldap

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
RUN echo "\n# Custom settings"                                    >> /etc/php/7.3/apache2/php.ini \
    && echo "error_log = /tmp/php_errors.log"                     >> /etc/php/7.3/apache2/php.ini \
    && echo "memory_limit = 256M"                                 >> /etc/php/7.3/apache2/php.ini \
    && echo "max_execution_time = 120"                            >> /etc/php/7.3/apache2/php.ini \
    && echo "file_uploads = On"                                   >> /etc/php/7.3/apache2/php.ini \
    && echo "post_max_size = 100M"                                >> /etc/php/7.3/apache2/php.ini \
    && echo "upload_max_filesize = 100M"                          >> /etc/php/7.3/apache2/php.ini \
    && echo "session.gc_maxlifetime = 14000"                      >> /etc/php/7.3/apache2/php.ini \
    && echo "display_errors = On"                                 >> /etc/php/7.3/apache2/php.ini \
    && echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /etc/php/7.3/apache2/php.ini

# Set PHP security settings
RUN echo "\n# Security settings"                    >> /etc/php/7.3/apache2/php.ini \
    && echo "session.name = CUSTOMSESSID"           >> /etc/php/7.3/apache2/php.ini \
    && echo "session.use_only_cookies = 1"          >> /etc/php/7.3/apache2/php.ini \
    && echo "session.cookie_httponly = true"        >> /etc/php/7.3/apache2/php.ini \
    && echo "session.use_trans_sid = 0"             >> /etc/php/7.3/apache2/php.ini \
    && echo "session.entropy_file = /dev/urandom"   >> /etc/php/7.3/apache2/php.ini \
    && echo "session.entropy_length = 32"           >> /etc/php/7.3/apache2/php.ini




## ------------- X-DEBUG ------------------
#PHP Install X-debug
RUN apt-get -y install php7.3-xdebug

#PHP X-Degub enable remote debug
RUN echo "xdebug.remote_enable=on" >> /etc/php/7.3/mods-available/xdebug.ini  \
    && echo "xdebug.remote_handler=dbgp" >> /etc/php/7.3/mods-available/xdebug.ini  \
    && echo "xdebug.remote_port=9000" >> /etc/php/7.3/mods-available/xdebug.ini  \
    && echo "xdebug.remote_autostart=on" >> /etc/php/7.3/mods-available/xdebug.ini  \
    && echo "xdebug.remote_connect_back=1" >> /etc/php/7.3/mods-available/xdebug.ini  \
    && echo "xdebug.idekey=docker" >> /etc/php/7.3/mods-available/xdebug.ini 

#PHP X-Degub enable log
RUN echo "xdebug.remote_log=/var/log/apache2/xdebug.log" >> /etc/php/7.3/mods-available/xdebug.ini


## ------------- Finishing ------------------
RUN apt-get clean

#Creating index of files
RUN updatedb

EXPOSE 80
CMD apachectl -D FOREGROUND
