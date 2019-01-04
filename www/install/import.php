<?php
require('vendor/autoload.php');
use Daveismyname\SqlImport\Import;

function importFile($filename,$hostdb){
    $username = 'form_exemplo';
    $password = '123456';
    $database = 'form_exemplo';
    $dropTables = true;
    new Import($filename, $username, $password, $database, $hostdb, $dropTables);
}