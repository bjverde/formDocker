# Lista de Versões Antigas (`old_version`)

Abaixo está a lista completa das pastas presentes em `old_version/` com um breve resumo (máximo de 250 caracteres) sobre o ambiente configurado no Docker de cada uma.

1. **`adianti_debian10_php8.0`**
   Ambiente Debian 10 com Apache 2 e PHP 8.0 configurado para o Adianti Framework. Inclui extensões PDO (SQLite, MySQL, PostgreSQL), LDAP, GD, cURL, MbString, Xdebug, Git, Composer e PHPUnit 9.

2. **`adianti_debian10_php8.1_mariadb`**
   Ambiente Debian 10 com Apache 2 e PHP 8.1 para Adianti (drivers SQLite, MySQL, SQL Server via ODBC 17/sqlsrv 5.10.1, MongoDB, LDAP, Xdebug 3 e mod_evasive), acompanhado dos containers MariaDB 10.11, Adminer e phpMyAdmin.

3. **`adianti_debian11_php8.1`**
   Ambiente Debian 11 com Apache 2 e PHP 8.1 para Adianti Framework. Inclui PDO (SQLite, MySQL, PostgreSQL), driver SQL Server (ODBC 17 e sqlsrv 5.10.0), MongoDB, LDAP, mod_evasive, Git, Composer e PHPUnit 9.

4. **`adianti_debian11_php8.1_mariadb`**
   Ambiente Debian 11 com Apache 2 e PHP 8.1 para Adianti (PDO SQLite/MySQL, MongoDB, ODBC 18, LDAP, Xdebug 3, mod_evasive, Composer e PHPUnit 9), orquestrado no Docker Compose junto com MariaDB 10.11, Adminer e phpMyAdmin.

5. **`debian10_php7.4_mssql`**
   Ambiente Debian 10 com Apache 2 e PHP 7.4 focado em conexão com SQL Server (MS ODBC 17 e drivers sqlsrv/pdo_sqlsrv 5.9.0). Conta também com PDO SQLite, MySQL, PostgreSQL, LDAP, Git, Composer e PHPUnit 9.

6. **`debian10_php8.0_mssql`**
   Ambiente Debian 10 com Apache 2 e PHP 8.0 configurado com driver para Microsoft SQL Server (ODBC 17 e sqlsrv/pdo_sqlsrv 5.9.0), além de PDO SQLite, MySQL, PostgreSQL, LDAP, Xdebug 3, Git, Composer e PHPUnit 9.

7. **`debian10_php8.1_mssql`**
   Ambiente Debian 10 com Apache 2 e PHP 8.1 com suporte a SQL Server (ODBC 17 e sqlsrv/pdo_sqlsrv 5.10.1) e MongoDB, além de PDO SQLite, MySQL, PostgreSQL, LDAP, Xdebug 3, Git, Composer e PHPUnit 9.

8. **`debian10_php8.2_mssql`**
   Ambiente Debian 10 com Apache 2 e PHP 8.2 preparado para SQL Server (ODBC 18 e sqlsrv/pdo_sqlsrv 5.11.0) e MongoDB, incluindo PDO SQLite, MySQL, PostgreSQL, LDAP, Xdebug 3, Git, Composer e PHPUnit 9.

9. **`debian11_php8.1_mssql`**
   Ambiente Debian 11 com Apache 2 e PHP 8.1 com suporte a SQL Server (ODBC 18, unixODBC 2.3.7 e sqlsrv/pdo_sqlsrv 5.10.1) e MongoDB, além de PDO SQLite, MySQL, PostgreSQL, LDAP, Git, Composer e PHPUnit 9.

10. **`debian11_php8.2_mssql`**
    Ambiente Debian 11 com Apache 2 e PHP 8.2 com suporte a SQL Server (ODBC 18, unixODBC 2.3.7 e sqlsrv/pdo_sqlsrv 5.11.0) e MongoDB, além de PDO SQLite, MySQL, PostgreSQL, LDAP, Git, Composer e PHPUnit 9.

11. **`debian9_php7.2_mysql_formdin`**
    Ambiente baseado em `php:7.2-apache` (Debian 9) e container MySQL 5.7. Inclui PDO MySQL, Zip, Xdebug, Git, Composer, PHPUnit 7 e scripts de instalação automática de exemplos do framework FormDin.

12. **`debian9_php7.3_mssql`**
    Ambiente Debian 9 com Apache 2 e PHP 7.3 conectado a um container SQL Server 2017 (`mssql/server:2017-GA-ubuntu`). Inclui MS ODBC 17, drivers sqlsrv/pdo_sqlsrv 5.8.1 e PDO para SQLite, MySQL e PostgreSQL.

13. **`debian_php7.1_mongo`**
    Ambiente composto por container `php:7.1-apache` e banco de dados MongoDB (`mongo`). A imagem PHP inclui extensão MongoDB via PECL, Xdebug 2.6.0, iconv, Zip e Git.

14. **`debian_php7.1_mysql`**
    Ambiente composto por container `php:7.1-apache` e banco de dados MySQL. A imagem PHP instala Git e a extensão `pdo_mysql` para conexão com o banco.

15. **`debian_php7.1_postgres`**
    Ambiente composto por container `php:7.1-apache` e banco de dados PostgreSQL (`postgres`). A imagem PHP conta com as extensões `pdo_pgsql`, Zip, Xdebug 2.6.0 e Git.

16. **`postgressql_pgadmin`**
    Arquivos Docker Compose para subir apenas o banco de dados PostgreSQL (versão `9.6` ou `latest`) na porta 5432 em conjunto com a interface de gerenciamento web pgAdmin 4 (`dpage/pgadmin4`) na porta 8080.

