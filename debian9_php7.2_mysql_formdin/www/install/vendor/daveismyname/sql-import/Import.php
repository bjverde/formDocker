<?php namespace Daveismyname\SqlImport;

use PDO;
use PDOException;
use Exception;
use Error;

/**
 * PDO class to import sql from a .sql file
 * adapted from thamaraiselvam's import-database-file-using-php class https://github.com/thamaraiselvam/import-database-file-using-php
 */
class Import
{
    private $db;
    private $filename;
    private $username;
    private $password;
    private $database;
    private $host;

    /**
      * instanciate
      * @param $filename string name of the file to import
      * @param $username string database username
      * @param $password string database password
      * @param $database string database name
      * @param $host string address host localhost or ip address
      * @param $dropTables boolean When set to true delect the database tables
    */
    public function __construct($filename, $username, $password, $database, $host, $dropTables)
    {
        //set the varibles to properties
        $this->filename = $filename;
        $this->username = $username;
        $this->password = $password;
        $this->database = $database;
        $this->host = $host;

        //connect to the datase
        $this->connect();

        //if dropTables is true then delete the tables
        if ($dropTables == true) {
            $this->dropTables();
        }

        //open file and import the sql
        $this->openfile();
    }

    /**
     * Connect to the database
    */
    private function connect() {
        try {
            $this->db = new PDO("mysql:host=".$this->host.";dbname=".$this->database, $this->username, $this->password);
            $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
            echo "Cannot connect: ".$e->getMessage()."\n";
        }
    }

    /**
     * run queries
     * @param string $query the query to perform
    */
    private function query($query)
    {
        try {
            return $this->db->query($query);
        } catch(Error $e) {
            echo "Error with query: ".$e->getMessage()."\n";
        }
    }

    /**
     * Select all tables, loop through and delete/drop them.
    */
    private function dropTables()
    {
        //get list of tables
        $tables = $this->query('SHOW TABLES');

        if ($tables != null) {
            //loop through tables
            foreach($tables->fetchAll(PDO::FETCH_COLUMN) as $table) {
                //delete table
            	$this->query('DROP TABLE `' . $table . '`');
            }
        }
    }

    /**
     * Open $filename, loop through and import the commands
    */
    private function openfile()
    {
        try {

            //if file cannot be found throw errror
            if (!file_exists($this->filename)) {
                throw new Exception("Error: File not found.\n");
            }

            // Read in entire file
            $fp = fopen($this->filename, 'r');

            // Temporary variable, used to store current query
            $templine = '';

            // Loop through each line
            while (($line = fgets($fp)) !== false) {

            	// Skip it if it's a comment
            	if (substr($line, 0, 2) == '--' || $line == '') {
            		continue;
                }

            	// Add this line to the current segment
            	$templine .= $line;

            	// If it has a semicolon at the end, it's the end of the query
            	if (substr(trim($line), -1, 1) == ';') {
                    $this->query($templine);

            		// Reset temp variable to empty
            		$templine = '';
            	}
            }

            //close the file
            fclose($fp);

        } catch(Exception $e) {
            echo "Error importing: ".$e->getMessage()."\n";
        }
    }
}
