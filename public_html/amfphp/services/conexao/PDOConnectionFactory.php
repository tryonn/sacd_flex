<?php

//final class PDOConnectionFactory extends PDO{
//
//	public function __construct(){
//		try {
//			parent::__construct('mysql:host=localhost;port=3306;dbname=crud_pdo','root', '');
//		} catch (PDOException $e) {
//			echo "Error: " .$e->getMessage();
//		}
//	}
//}


final class PDOConnectionFactory {
    static $db ;
    private $dbh ;
    private function __construct() {
        
        $db_type = 'mysql';  //ex) mysql, postgresql, oracle
        $db_name = 'sacd';
        $user = 'root' ;
        $password = '' ;
        $host = 'localhost' ;
        try {
            $dsn = "$db_type:host=$host;dbname=$db_name";
            $this->dbh = new PDO ( $dsn, $user, $password);
            $this->dbh->setAttribute(PDO::ATTR_PERSISTENT, true);
            $this->dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch ( PDOException $e ) {
            print "Error!: " . $e->getMessage () . "\n" ;
            die () ;
        }
    }
 
    public static function getInstance (  ) {
        if (! isset ( PDOConnectionFactory::$db )) {
            PDOConnectionFactory::$db = new PDOConnectionFactory ( ) ;
        }
        return PDOConnectionFactory::$db->dbh;
    }
     public function Close() {
        self::$db = NULL;
    }
}
?>