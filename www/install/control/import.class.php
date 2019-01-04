<?php
use Daveismyname\SqlImport\Import;

class import
{
    public static function exec($filename,$hostdb){
        $username = 'form_exemplo';
        $password = '123456';
        $database = 'form_exemplo';
        $dropTables = true;
        new Import($filename, $username, $password, $database, $hostdb, $dropTables);
    }
}