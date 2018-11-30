# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://hub.docker.com/_/ubuntu/

#How to build
#sudo docker build -f ubuntu_apache_php70.Dockerfile . -t ubuntu_php70

#How use iterative mode
#sudo docker exec -it ubuntu_php70 /bin/bash

#######################################
FROM ubuntu:18.04
LABEL maintainer="bjverde@yahoo.com.br"

#Install facilitators
RUN apt-get update && apt-get -y upgrade

#Install facilitators
RUN apt-get update && apt-get -y install locate mlocate apt-utils

#Install Apache2 + PHP 7.2
RUN apt-get -y install apache2 php libapache2-mod-php php-mysql

#Creating index of files
RUN updatedb