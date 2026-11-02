# Ambiente Docker

* Debian 11
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
* PHP 8.1.X
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
    * Xdebug 3.X - DESATIVADO por padrão
* Composer
* PHPUnit 9.X
* GIT

## Rodando
Para facilitar a vida foi usado um Docker com Docker-compose basta executar  `docker-compose up --build` e aguardar.

* pasta `www` local do seu projeto. Equivale a pasta `/var/www/html`
* pasta `log` contem todos os arquivos de log de `/var/log/apache2`

### Alterando o PHP.INI
Altere o arquivo php.ini na raiz da pasta depois rode novamente `docker-compose up --build` com isso as novas configurações estarão disponiveis. 

Configurações mais comuns
* `display_errors = On` linha 503 - mostra os erros na tela
* `error_reporting = E_ALL` linha 486 - mostra todos os tipos de erros
* `post_max_size = 80M` linha 698 - altera o tamanho maximo do post
* `upload_max_filesize = 20M` linha 850 - altera o tamanho do upload de arquivo


## X-Debug
Vem desativado por padrão para ativar basta descomentar as linhas
* 115
* 118 e 119
* 122