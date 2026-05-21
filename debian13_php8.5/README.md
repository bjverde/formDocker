# Docker PHP

Configuração futura do STI

## Config
* Debian 13
    * plocate
    * wget
    * curl
    * apt-transport-https
    * lsb-release
    * vim 
    * rpl
* Apache 2.4.X
    * AllowOverride All
    * LDAP Ligado
* PHP 8.5.X
    * PDO
        * SqLite
        * MySQL
        * PostGres
    * MbString
    * CURL
    * JSON
    * XML
    * ZIP
    * PDO - Sql Server
        * Drive SqlServer 5.13
        * ODBC 18
    * Xdebug - DESATIVADO por padrão
* Composer
* PHPUnit 13.x
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
Vem desativado por padrão para ativar basta descomentar as linhas abaixo no arquivo  `.Dockerfile`
* 115
* 118 e 119
* 122