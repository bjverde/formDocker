# Docker PHP

Docker com Debian 13, PHP 8.5, Apache 2.4.X, PostgreSQL e pgAdmin

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

# Comandos úteis

## Relação entre Host e Docker

copiar arquivo do docker para maquina local
```bash
sudo docker cp nome_container:caminho_no_container caminho_local
```
Exemplo 
```bash
docker cp debian13_apache_php85_mssql:/etc/php/8.5/apache2/php.ini ./php.ini
```
----

Como copiar arquivo do host para o container

```bash
sudo docker cp caminho_local nome_container:caminho_no_container
```
Exemplo 
```bash
sudo docker cp ./php.ini debian13_apache_php85_mssql:/etc/php/8.5/apache2/php.ini
```
## docker compose 

Subir compose em foreground e compilar
```bash
sudo docker-compose up --build
```

Subir compose em background (somente se ja tiver compilado antes)
```bash
sudo docker-compose up -d
```

Subir compose em background e compilar
```bash
sudo docker-compose -f docker-compose.yml up -d --build
```

Como acessar o modo iterativo no container somente se estiver rodando
```bash
sudo docker-compose exec apache_php bash
```

Parar compose
```bash
sudo docker-compose down
```

Parar compose e remover containers, volumes e redes
```bash
sudo docker-compose down --rmi all --volumes --remove-orphans
```

## apenas docker
Como listar todos os containers
```bash
sudo docker ps -a
```

Como parar todos os containers
```bash
sudo docker stop $(sudo docker ps -a -q)
```

Como remover todos os containers
```bash
sudo docker rm $(sudo docker ps -a -q)
```

[<-- Voltar para inicio](../README.md)