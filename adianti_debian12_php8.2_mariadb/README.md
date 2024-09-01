# adianti-gabarito
Script Docker / Compose baseada em Debian 12 para desenvolvimento PHP com [Adianti Framework](https://www.adianti.com.br/framework). O container rodará Apache/2.4.29 e PHP 8.2.X, bem como todos os módulos e extensões necessárias para a correta execução do framework. 

Esse ambiente foi configurado conforme o tutorial [Preparando um servidor gabarito para o Adianti Framework (com Ubuntu 22.04 e PHP 8.1)](https://www.adianti.com.br/forum/pt/view_7397?preparando-um-servidor-gabarito-para-o-adianti-framework-com-ubuntu-2204-e-php-81) escrito por [Pablo Dall'Oglio](http://www.dalloglio.net/).

*ESTA CONFIGURADO PARA DESENVOLVIMENTO COM XDebug*

# Detalhando o Ambiente

* Debian 12
    * locate
    * mlocate
    * wget
    * curl
    * apt-transport-https
    * lsb-release
    * vim 
    * rpl
* Apache 2.4.X
    * AllowOverride All
    * LDAP Ligado
* PHP 8.2.X
    * CURL
    * JSON
    * MbString
    * XML
    * ZIP
    * Drive MongoDB
    * PDO - SqLite
    * PDO - MySQL
    * PDO - PostGres
    * PDO - Sql Server
        * Drive SqlServer 5.10
        * ODBC 17
        * OpenSSL 1.1.1-g 2020
    * Xdebug 3.X - ATIVADO por padrão
* Composer
* PHPUnit 11.X
* GIT
* MariaDB Versão 10.11
* PHPMyAdmin - [http://localhost:9090](http://localhost:9090)
* adminer    - [http://localhost:8080](http://localhost:8080)

## Banco MariaDb
* servidor: mariadb
* MYSQL_ROOT_PASSWORD: p123456
* MYSQL_DATABASE: mybb
* MYSQL_USER: mybb
* MYSQL_PASSWORD: mybb


## Rodando
Para facilitar a vida foi usado um Docker com Docker-compose basta executar  `docker-compose up --build` e aguardar.

* pasta `www` local do seu projeto. Equivale a pasta `/var/www/html`
* pasta `log` contem todos os arquivos de log de `/var/log/apache2`

### Alterando o PHP.INI
Altere o arquivo php.ini na raiz da pasta depois rode novamente `docker-compose up --build` com isso as novas configurações estarão disponiveis. 

Configurações mais comuns
* `display_errors = On` linha 503 - mostra os erros na tela
* `error_reporting = E_ALL` linha 486 - mostra todos os tipos de erros
* `post_max_size = 100M` linha 698 - altera o tamanho maximo do post
* `upload_max_filesize = 100M` linha 850 - altera o tamanho do upload de arquivo


## X-Debug
Vem ativado por padrão para ativar basta comentar as linhas no arquivo `adianti_debian12_php8.2.Dockerfile` para desativar.
* 131
* 134,135 e 136
* 139


# Alterando para modo produção.

1. Alterar arquivo php.ini `display_errors = off` na linha 503 - para não mostrar os errados na tela
1. Alterar arquivo php.ini `error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT` linha 486 - mostra todos os tipos de erros
1. Alterar arquivo `adianti_debian12_php8.2.Dockerfile` e comentar as linahs 130 até 139
1. Alterar arquivo `adianti_debian12_php8.2.Dockerfile` e comentar as linahs 222 para desativar a porta 9003