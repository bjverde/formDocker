# Source
# https://hub.docker.com/_/php/
# Docker File Source
# https://hub.docker.com/_/ubuntu/

#How to build
#sudo docker build -f ubuntu_apache_php70.Dockerfile . -t ubuntu_apache_php70

#How use iterative mode
#sudo docker exec -it ubuntu_apache_php70:16.04 /bin/bash

#How use iterative mode image
#sudo docker run -it ubuntu_apache_php70:16.04 /bin/bash           #only bash
#sudo docker run -p 80:80 -it ubuntu_apache_php70:16.04 /bin/bash
#sudo docker run -d -p 80:80 ubuntu_apache_php70:16.04

#######################################
FROM ubuntu:16.04
LABEL maintainer="bjverde@yahoo.com.br"
#COPY ./www /var/www/html
#WORKDIR /var/www/html


#Install update
RUN apt-get update && apt-get -y upgrade

#Install facilitators
RUN apt-get -y install locate mlocate wget

#Install Apache2 + PHP 7.0.32 x86_64 
# Thread Safety 	disabled 

#PHP Modules : calendar,Core,ctype,date,exif,fileinfo,filter,ftp,gettext,hash,iconv,json,libxml,mysqli,mysqlnd
#PHP Modules : ,openssl,pcntl,pcre,PDO,pdo_mysql,Phar,posix,readline,Reflection,session,shmop,sockets,SPL,standard
#PHP Modules : ,sysvmsg,sysvsem,sysvshm,tokenizer,Zend OPcache,zlib
RUN apt-get -y install apache2 php libapache2-mod-php php-cli


#apache2 php libapache2-mod-php php-curl php-dom php-gd php-json php-ldap php-mbstring php-pdo php-pdo-mysql php-pdo-sqlite php-xml php-zip php-tokenizer php-cli php-xdebug

#PHP Install CURl
#RUN apt-get -y install curl php-curl

#PHP Install PDO SqLite
#RUN apt-get -y install php-pdo php-pdo-sqlite php-sqlite3

#PHP Install PDO MySQL
#RUN apt-get -y php-pdo php-pdo-mysql php-mysql 

#PHP Install PDO PostGress
#RUN apt-get -y install php-pdo php-pgsql

#PHP Install MbString
#RUN apt-get -y install php-mbstring

#PHP Install X-debug
#RUN apt-get -y install php-xdebug

RUN apt-get clean

#Creating index of files
RUN updatedb


EXPOSE 80
CMD apachectl -D FOREGROUND
