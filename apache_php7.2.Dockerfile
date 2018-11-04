# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://github.com/docker-library/php/blob/master/7.2/stretch/apache/Dockerfile

#How to build
#sudo docker build -f apache_php7.2.Dockerfile . -t bjverde/php7.2

#How use iterative mode
#sudo docker exec -it apache_php /bin/bash

#######################################
FROM php:7.2-apache 
LABEL maintainer="bjverde@yahoo.com.br"
#COPY ./www /var/www/html
#WORKDIR /var/www/html
EXPOSE 80

#PHP Modules : curl, date, dom, fileinfo, filter, ftp, hash, iconv, json, libxml, libxml, openssl, PDO, pdo_sqlite, Phar, posix, SimpleXML

#Install facilitators
RUN apt-get update && apt-get install locate mlocate

#Install GIT
#RUN apt-get update && apt-get install -y git-core

#PHP PDO 
RUN docker-php-ext-install pdo

#PHP PDO MySQL
RUN docker-php-ext-install pdo_mysql

#PHP PDO PostgreSql
#RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo_pgsql

#PHP Zip
#RUN apt-get update && apt-get install -y zlib1g-dev && docker-php-ext-install zip

####
# https://imasters.com.br/devsecops/como-usar-o-xdebug-dentro-de-um-container-docker
# https://github.com/felixfbecker/vscode-php-debug/issues/240
# https://tsayao.com.br/735/docker-mysql-nginx-php-com-debug-visual-studio-code-e-intellij-idea-php-storm/
# https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug
####

#PHP X-Degub install
RUN pecl install xdebug && docker-php-ext-enable xdebug

#PHP X-Degub enable remote debug
RUN echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini  \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini  \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini  \
    && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini  \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini  \
    && echo "xdebug.idekey=docker" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 

#PHP X-Degub enable log
RUN echo "xdebug.remote_log=/tmp/xdebug_log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


#Creating index of files
RUN updatedb

RUN cat /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini