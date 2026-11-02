# 🐳 Docker PHP 8.5 + PostgreSQL + pgAdmin (Debian 13)

Ambiente Docker completo baseado em **Debian 13**, **Apache 2.4.X**, **PHP 8.5**, **PostgreSQL** e **pgAdmin 4**, pronto para desenvolvimento local.

> [!WARNING]
> **Ambiente de Desenvolvimento:**
> Este ambiente vem configurado para facilitar o desenvolvimento e depuração local (com exibição de erros ativa no Apache). Para uso em **produção**, desative o `display_errors` no `config/php-apache.ini`, mantenha o **Xdebug desligado** em `config/xdebug.ini` e altere as senhas padrão no `docker-compose.yml`.

---

## 📦 Detalhamento do Ambiente

* **Sistema Operacional:** Debian 13 (`trixie`)
  * Utilitários: `plocate`, `wget`, `curl`, `apt-transport-https`, `lsb-release`, `vim`, `rpl`, `zip`, `unzip`, `gnupg`
* **Servidor Web:** Apache 2.4.X
  * `mod_rewrite` ativado e `AllowOverride All` habilitado para leitura de `.htaccess`
  * Módulo LDAP (`authnz_ldap` e `ldap`) habilitado
* **PHP 8.5.X:**
  * **Drivers PDO de Banco de Dados:**
    * PostgreSQL (`pdo_pgsql` e `pgsql`)
    * MySQL / MariaDB (`pdo_mysql` e `mysql`)
    * SQLite (`pdo_sqlite` e `sqlite3`)
    * Microsoft SQL Server (`sqlsrv` e `pdo_sqlsrv` 5.13.0 + Microsoft ODBC Driver 18)
  * **NoSQL:** Extensão MongoDB (`php8.5-mongodb`)
  * **Extensões adicionais:** `mbstring`, `curl`, `dom`, `json`, `xml`, `zip`, `gd`, `soap`, `intl`, `xsl`, `ldap`
  * **Xdebug 3.X:** Desativado por padrão (configurável em `config/xdebug.ini`)
* **Ferramentas de Desenvolvimento:**
  * Composer
  * PHPUnit 13.X
  * Git
* **Containers Adicionais no `docker-compose.yml`:**
  * **PostgreSQL (`database`):** Banco de dados relacional na porta `5432` com persistência em `./postgres_database` e logs em `./logs/postgresql.log`
  * **pgAdmin 4 (`pgadmin`):** Interface web de administração rodando em [http://localhost:8080](http://localhost:8080)

---

## 🚀 Subindo o Ambiente

Na raiz desta pasta (`debian13_php8.5_pgsql`), execute:

```bash
docker-compose up --build
```
*(Ou `docker-compose up -d --build` para rodar em segundo plano)*

### 🔗 Endereços e Credenciais Padrão

| Serviço | URL / Host | Usuário | Senha | Observação |
| :--- | :--- | :--- | :--- | :--- |
| **Apache / PHP** | [http://localhost](http://localhost) | — | — | Página inicial com links e listagem de projetos em `www/` |
| **PHPInfo** | [http://localhost/info.php](http://localhost/info.php) | — | — | Exibe todas as extensões e diretivas do PHP |
| **pgAdmin 4 (Web)** | [http://localhost:8080](http://localhost:8080) | `user@domain.com` | `123456` | Login para entrar na interface web do pgAdmin |
| **PostgreSQL (Banco)** | Host interno: `database` (ou `localhost:5432` no host) | `postgres` | `postgres` | Banco padrão: `postgres` (alterável no `docker-compose.yml`) |

---

## ⚙️ Estrutura de Pastas e Configurações (`config/`)

Todos os arquivos de configuração, dados e logs ficam organizados em pastas dedicadas e mapeados via volumes no [`docker-compose.yml`](docker-compose.yml):

```text
debian13_php8.5_pgsql/
├── config/
│   ├── php-apache.ini       # Configurações do PHP para o Apache (/etc/php/8.5/apache2/php.ini)
│   ├── php-cli.ini          # Configurações do PHP para o terminal CLI (/etc/php/8.5/cli/php.ini)
│   ├── xdebug.ini           # Ativação e ajustes do Xdebug (/etc/php/8.5/apache2/conf.d/20-xdebug.ini)
│   ├── apache_default.conf  # VirtualHost padrão do Apache (/etc/apache2/sites-enabled/000-default.conf)
│   ├── servers.json         # Pré-cadastro automático do servidor PostgreSQL no pgAdmin 4
│   └── postgresql.conf      # Configurações customizadas opcionais para o PostgreSQL
├── logs/                    # Logs do Apache (access.log, error.log) e do PostgreSQL (postgresql.log)
├── postgres_database/       # Dados persistidos do banco PostgreSQL (/var/lib/postgresql/data)
├── www/                     # Código-fonte dos seus projetos (/var/www/html)
├── debian13_apache_php85_pgsql.Dockerfile
└── docker-compose.yml
```

### 1. Persistência e Logs do PostgreSQL (`postgres_database/` e `logs/`)
* **Persistência (`./postgres_database`):** Ativada por padrão no `docker-compose.yml` com `PGDATA=/var/lib/postgresql/data/pgdata`, garantindo que seus bancos e tabelas não sejam perdidos ao parar ou recriar o container.
* **Logs (`./logs/postgresql.log`):** Por padrão a imagem oficial do Postgres envia logs apenas para o console do Docker (`stderr`). Neste `docker-compose.yml`, o `logging_collector=on` foi ativado apontando para `/var/log/postgresql`, gravando o arquivo `postgresql.log` diretamente na pasta `./logs/` junto com os logs do Apache.

### 2. `config/php-apache.ini` e `config/php-cli.ini`
Permitem customizar separadamente o comportamento do PHP no servidor web (`php-apache.ini`) e na linha de comando (`php-cli.ini`). Após editar, basta reiniciar o container:
```bash
docker-compose restart apache_php
```
**Configurações mais comuns no `config/php-apache.ini`:**
* `display_errors = On` (linha 503) — exibe erros na tela durante o desenvolvimento (mude para `Off` em produção).
* `error_reporting = E_ALL` (linha 486) — nível de detalhamento dos erros.
* `post_max_size = 80M` (linha 698) — limite máximo de dados via POST.
* `upload_max_filesize = 20M` (linha 850) — tamanho máximo de upload de arquivos.

### 3. `config/apache_default.conf`
Define o `VirtualHost *:80` do Apache apontando para `/var/www/html` com `AllowOverride All`. Ideal caso você precise configurar redirecionamentos, cabeçalhos customizados ou alterar o `DocumentRoot`.

### 4. `config/xdebug.ini` (Ativando / Desativando o Xdebug)
O Xdebug vem **desativado por padrão** para garantir máxima velocidade no dia a dia.
* **Para ativar:**
  1. Caso a extensão ainda não esteja instalada na imagem, descomente a linha `RUN apt-get -y install php8.5-xdebug` no `.Dockerfile` e faça o build uma única vez.
  2. No arquivo [`config/xdebug.ini`](config/xdebug.ini), descomente a linha `;zend_extension=xdebug.so` (removendo o `;`).
  3. Reinicie o container sem precisar reconstruir a imagem:
     ```bash
     docker-compose restart apache_php
     ```
* **Para desativar (ou em produção):** Comente novamente `;zend_extension=xdebug.so` em `config/xdebug.ini` e reinicie o container.

### 5. `config/servers.json` (Servidor Pré-Cadastrado no pgAdmin)
Este arquivo é montado automaticamente no container do pgAdmin (`/pgadmin4/servers.json`). Graças a ele, ao fazer login no pgAdmin (`http://localhost:8080`), o servidor **`PostgreSQL Docker (database)`** já estará cadastrado na lista de servidores — bastando informar a senha `postgres` na primeira conexão.

### 6. `config/postgresql.conf`
Arquivo opcional com parâmetros do banco PostgreSQL (`max_connections`, `shared_buffers`, `timezone = 'America/Sao_Paulo'`, `log_statement`). Para utilizá-lo por completo, basta descomentar a linha do volume `./config/postgresql.conf` no serviço `database` dentro do [`docker-compose.yml`](docker-compose.yml).

---

## 🛠️ Comandos Úteis

Veja a lista de comandos úteis do Docker em [../docs/commands.md](../docs/commands.md).

[<-- Voltar para o início](../README.md)
