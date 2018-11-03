# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://github.com/docker-library/php/blob/master/7.2/stretch/apache/Dockerfile

#How to build
#docker build -f apache_php7.2.Dockerfile . -t bjverde/php7.2

FROM php:7.2-apache 
LABEL maintainer="bjverde@yahoo.com.br"
#COPY ./www /var/www/html
#WORKDIR /var/www/html
EXPOSE 80

#Install GIT
#RUN apt-get update && apt-get install -y git-core

#PHP PDO 
RUN docker-php-ext-install pdo

#PHP PDO MySQL
RUN docker-php-ext-install pdo_mysql

#PHP JSON
RUN docker-php-ext-install json && docker-php-ext-enable json

#PHP PDO SQLite
# RUN apt-get install sqlite libsqlite3-dev
#RUN docker-php-ext-install pdo_sqlite && docker-php-ext-enable pdo_sqlite

#PHP PDO PostgreSql
#RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo_pgsql

#PHP Zip
#RUN apt-get update && apt-get install -y zlib1g-dev && docker-php-ext-install zip



#PHP X-Degub
RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug