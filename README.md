# 🐳 FormDocker

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)
![Apache](https://img.shields.io/badge/Apache-D22128?style=for-the-badge&logo=apache&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)

🇧🇷 [Português](#-português-pt-br) | 🇺🇸 [English](#-english)

---

## 🇧🇷 Português (PT-BR)

O **FormDocker** reúne arquivos `Dockerfile` e `docker-compose.yml` prontos para montar rapidamente ambientes de desenvolvimento contendo:
* **Servidor Web:** Apache 2 + PHP (com extensões pré-configuradas, Composer, PHPUnit, Git e Xdebug)
* **Bancos de Dados e Gerenciadores:** Drivers e containers para PostgreSQL, MariaDB/MySQL, Microsoft SQL Server, SQLite e MongoDB

Projetado especialmente para projetos com:
* [**Adianti Framework**](https://www.adianti.com.br/) e [**SysGenAD System Generator**](https://github.com/bjverde/sysgen/releases/latest)
* [**FormDin Framework**](https://github.com/bjverde/formDin) e [**SysGen System Generator**](https://github.com/bjverde/sysgen/releases/latest)

> [!WARNING]
> **Atenção — Foco em Ambiente de Desenvolvimento:**
> Todos os scripts deste repositório são voltados para **ambiente de desenvolvimento**. Caso deseje utilizá-los como base para **produção**, é fundamental revisar e ajustar as configurações de segurança e desempenho para a sua necessidade, **principalmente**:
> 1. **Desativar o Xdebug** no `Dockerfile` / `php.ini` e remover o mapeamento da porta `9003` no `docker-compose.yml` (o Xdebug impacta severamente a performance e expõe o ambiente).
> 2. **Desativar a exibição de erros** (`display_errors = Off` no `php.ini`).
> 3. **Alterar senhas padrão** de bancos de dados e ferramentas administrativas (phpMyAdmin, Adminer, pgAdmin), ou removê-las em produção.

### 📂 Ambientes Disponíveis (Atuais)

Escolha a pasta que melhor atende ao seu projeto:

| Pasta | Sistema / PHP | Bancos / Serviços Incluídos | Documentação |
| :--- | :--- | :--- | :--- |
| **`debian13_php8.5_pgsql`** | Debian 13 + PHP 8.5 | Drivers PDO (PgSQL, MySQL, SQLite, SQL Server, MongoDB) + Containers **PostgreSQL** e **pgAdmin 4** | [README](debian13_php8.5_pgsql/README.md) |
| **`debian13_php8.5_mssql`** | Debian 13 + PHP 8.5 | Drivers PDO (SQL Server ODBC 18 / `sqlsrv` 5.13, PgSQL, MySQL, SQLite, MongoDB) | [README](debian13_php8.5_mssql/README.md) |
| **`adianti_debian12_php8.2`** | Debian 12 + PHP 8.2 | Ambiente gabarito Adianti com drivers PDO (MySQL, PgSQL, SQLite, SQL Server, MongoDB) | [README](adianti_debian12_php8.2/README.md) |
| **`adianti_debian12_php8.2_mariadb`** | Debian 12 + PHP 8.2 | Ambiente gabarito Adianti + Containers **MariaDB 10.11**, **phpMyAdmin** e **Adminer** | [README](adianti_debian12_php8.2_mariadb/README.md) |

📦 **Versões anteriores (Debian 9, 10, 11 e PHP 7.1 a 8.2):** estão arquivadas na pasta [`old_version/`](old_version/). Veja o catálogo completo em [**docs/list_old_version.md**](docs/list_old_version.md).

### 🚀 Como Usar

1. Instale o **Docker** / **Docker Desktop** conforme o seu sistema operacional (veja o guia na [Wiki: Usando o Docker](https://github.com/bjverde/formDin/wiki/Usando-o-Docker)).
2. Acesse a pasta do ambiente desejado e execute:
   ```bash
   docker-compose up --build
   ```
   *(ou `docker-compose up -d --build` para rodar em segundo plano)*
3. Coloque os arquivos da sua aplicação dentro da pasta `www/` do ambiente escolhido.
4. Veja uma lista de comandos uteis em [/docs/commands.md](/docs/commands.md)

---

## 🇺🇸 English

**FormDocker** provides ready-to-use `Dockerfile` and `docker-compose.yml` templates to quickly spin up development environments featuring:
* **Web Server:** Apache 2 + PHP (with pre-configured extensions, Composer, PHPUnit, Git, and Xdebug)
* **Databases & Admin Tools:** Drivers and containers for PostgreSQL, MariaDB/MySQL, Microsoft SQL Server, SQLite, and MongoDB

Tailored for projects built with:
* [**Adianti Framework**](https://www.adianti.com.br/) and [**SysGenAD System Generator**](https://github.com/bjverde/sysgen/releases/latest)
* [**FormDin Framework**](https://github.com/bjverde/formDin) and [**SysGen System Generator**](https://github.com/bjverde/sysgen/releases/latest)

> [!WARNING]
> **Important — Development Environment Only:**
> All scripts in this repository are designed for **local development environments**. Before adapting any configuration for **production**, you must review what is necessary for your infrastructure and security requirements, **especially**:
> 1. **Disabling Xdebug** in the `Dockerfile` / `php.ini` and removing port `9003` from `docker-compose.yml` (Xdebug causes significant performance overhead and security risks in production).
> 2. **Disabling error display** (`display_errors = Off` in `php.ini`).
> 3. **Changing default credentials** for databases and management tools (phpMyAdmin, Adminer, pgAdmin).

### 📂 Available Environments

| Folder | OS / PHP | Included Drivers & Services | Docs |
| :--- | :--- | :--- | :--- |
| **`debian13_php8.5_pgsql`** | Debian 13 + PHP 8.5 | PDO Drivers (PgSQL, MySQL, SQLite, SQL Server, MongoDB) + **PostgreSQL** & **pgAdmin 4** containers | [README](debian13_php8.5_pgsql/README.md) |
| **`debian13_php8.5_mssql`** | Debian 13 + PHP 8.5 | PDO Drivers (SQL Server ODBC 18 / `sqlsrv` 5.13, PgSQL, MySQL, SQLite, MongoDB) | [README](debian13_php8.5_mssql/README.md) |
| **`adianti_debian12_php8.2`** | Debian 12 + PHP 8.2 | Adianti template with PDO drivers (MySQL, PgSQL, SQLite, SQL Server, MongoDB) | [README](adianti_debian12_php8.2/README.md) |
| **`adianti_debian12_php8.2_mariadb`** | Debian 12 + PHP 8.2 | Adianti template + **MariaDB 10.11**, **phpMyAdmin**, and **Adminer** containers | [README](adianti_debian12_php8.2_mariadb/README.md) |

📦 **Legacy versions (Debian 9, 10, 11 and PHP 7.1 to 8.2):** archived in [`old_version/`](old_version/). See the full list in [**docs/list_old_version.md**](docs/list_old_version.md).
