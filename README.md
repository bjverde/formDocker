# About

formDocker are files from the Docker Composer to mount the [FormDin FrameWork](https://github.com/bjverde/formDin) environment with: Apache / PHP, Database, [FormDin FrameWork](https://github.com/bjverde/formDin) and [SysGen System Generator](https://github.com/bjverde/sysgen/releases/latest)
formDocker is

There are several example Docker-compose files. Choose a folder as you wish. The default installation is:
* Debian 9
* Apahce 2.4
* PHP 7.2
* MySQL 5.7
* [formDin latest version](https://github.com/bjverde/formDin/releases/latest)
* [SysGen latest version](https://github.com/bjverde/sysgen/releases/latest)

# PT-BR
formDocker são arquivos do Docker Compose para montar o ambiente do [FormDin FrameWork](https://github.com/bjverde/formDin) com: Apache/PHP, Banco de dados, o [FormDin FrameWork](https://github.com/bjverde/formDin) e o [gerador de sistemas SysGen](https://github.com/bjverde/sysgen/releases/latest)


Existem diversos arquivos Docker-compose de exemplo. Escolha uma pasta conforme seu desejo. A instalação padrão é:
* Debian 9
* Apahce 2.4
* PHP 7.2
* MySQL 5.7
* [formDin ultima versão](https://github.com/bjverde/formDin/releases/latest)
* [SysGen ultima versão](https://github.com/bjverde/sysgen/releases/latest)


# Windows 7 

## Requisito
* Espaço em Disco : aproximadamente 2 GB no C:

## Instalação
1. Instalar o [Docker ToolBox](https://docs.docker.com/toolbox/toolbox_install_windows/). O Docker tem todo o ambiente para rodar aplicação.
1. Instalar o git para baixar com maior facilidade as atualizações.
1. Em documentos do usuário criar a pasta Kitematic
1. Entrar na pasta Kitematic via Windows Explorar, na barra de endereço digitar CMD
1. No terminal do Windows digitar `git clone https://github.com/bjverde/formDocker.git`
1. Clicar no *Docker Quickstart Terminal*. Essa tarefa pode demorar alguns segundos
1. Digitar o comando `cd /c/Users/<SEU USUARIO DO WINDOWS>/Documents/Kitematic/formDocker/`. Subistituindo o `<SEU USUARIO DO WINDOWS>` pelo seu usuario do windows.
1. Digitar o comando `docker-compose up --build` - para montar todo o ambiente nescessario. Essa etapa é demorada e pode levar alguns minutos dependendo da velocidade da sua internet.
1. Acesse http://192.168.99.100/ será a ultima etapa da instalação, com um pequeno Wizard


## Executando novamente
1. Clicar no *Docker Quickstart Terminal*. Essa tarefa pode demorar alguns segundos.
1. Digitar o comando `cd /c/Users/<SEU USUARIO DO WINDOWS>/Documents/Kitematic/cargaCorretagem/`. Subistituindo o `<SEU USUARIO DO WINDOWS>` pelo seu usuario do windows.
1. Digitar o comando `docker-compose up` - será bem mais rapido que na instalação.
1. Acesse http://192.168.99.100/ você será direcionado para o local correto