#docker build -f php.Dockerfile . -t bjverde/php7.1

FROM php:7.1-apache 
LABEL maintainer="bjverde@yahoo.com.br"
#COPY ./www /var/www/html
#WORKDIR /var/www/html
EXPOSE 80

#Install GIT
RUN apt-get update && apt-get install -y git-core

#PHP PDO MySQL
RUN docker-php-ext-install pdo_mysql

#PHP PDO PostgreSql
#RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo_pgsql

#PHP Zip
#RUN apt-get update && apt-get install -y zlib1g-dev && docker-php-ext-install zip