#How to build
#sudo docker build -f apache_php7.1_monogo.Dockerfile . -t apache_php71

FROM php:7.1-apache 
LABEL maintainer="bjverde@yahoo.com.br"
#COPY ./www /var/www/html
#WORKDIR /var/www/html
EXPOSE 80

#Install GIT
RUN apt-get update && apt-get install -y git-core

# PHP: X-Degub
RUN pecl install xdebug-2.6.0 && docker-php-ext-enable xdebug

# PHP: Install mb string exention and iconv
RUN docker-php-ext-install iconv
#RUN docker-php-ext-install iconv mbstring

# PHP: Install zip extension
RUN apt-get update && apt-get install -y zlib1g-dev && docker-php-ext-install zip


#PHP PDO MySQL
#RUN docker-php-ext-install pdo_mysql

#PHP PDO PostgreSql
#RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo_pgsql


# install mongodb ext
RUN pecl install mongodb && docker-php-ext-enable mongodb