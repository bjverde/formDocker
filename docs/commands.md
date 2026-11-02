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