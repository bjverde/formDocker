# https://laravel-news.com/install-microsoft-sql-drivers-php-7-docker
# How to build
# sudo docker build -f php.Dockerfile . -t server-demo

FROM php:7.1-apache

ENV ACCEPT_EULA=Y

# Microsoft SQL Server Prerequisites
RUN apt-get update \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/8/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get install -y --no-install-recommends \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        msodbcsql \
        unixodbc-dev

RUN docker-php-ext-install mbstring pdo pdo_mysql \
    && pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv


# PHP: X-Degub
RUN pecl install xdebug && docker-php-ext-enable xdebug

COPY index.php /var/www/html/
