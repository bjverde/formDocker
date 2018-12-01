# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://hub.docker.com/_/ubuntu/

#How to build
#sudo docker build -f ubuntu_apache_php70.Dockerfile . -t ubuntu_apache_php70

#How use iterative mode
#sudo docker exec -it ubuntu_apache_php70 /bin/bash

#How use iterative mode image
#sudo docker run -p 80:80 -it ubuntu_apache_php70:latest /bin/bash
#sudo docker run -d -p 80:80 ubuntu_apache_php70:latest

#######################################
FROM ubuntu:16.04
LABEL maintainer="bjverde@yahoo.com.br"
#COPY ./www /var/www/html
#WORKDIR /var/www/html
EXPOSE 80

#Install update
RUN apt-get update && apt-get -y upgrade

#Install facilitators
RUN apt-get -y install locate mlocate apt-utils

#Install Apache2 + PHP 7.0
RUN apt-get -y install apache2 php libapache2-mod-php php-mysql

#Creating index of files
RUN updatedb

RUN php -v