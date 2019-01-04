# php Import SQL
PDO import sql from a .sql file

### Install

Using composer include the repository by typing the following into a terminal

```
composer require daveismyname/sql-import
```

### Usage

Include the composer autoloader, import the Import namespace.

Define your database file path and credentials, the last option `dropTables` when set to true will delete all the tables in the database before import the sql file.

```
<?php
require('vendor/autoload.php');

use Daveismyname\SqlImport\Import;

$filename = 'database.sql';
$username = 'root';
$password = '';
$database = 'sampleproject';
$host = 'localhost';
$dropTables = true;
new Import($filename, $username, $password, $database, $host, $dropTables);
```
