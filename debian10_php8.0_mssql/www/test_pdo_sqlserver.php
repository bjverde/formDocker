<?php

/***
 * By Peter Stalman (Sarke) 
 * https://github.com/microsoft/msphpsql/issues/927
 */
function getPortSqlServer($host, $instance) {
	$msg = chr(4) . $instance;
	// make the UDP request
	$socket = socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);
	socket_connect($socket, $host, 1434);
	socket_write($socket, $msg, strlen($msg));
	$buf = '';
	socket_recv($socket, $buf, 2048, MSG_WAITALL);
	socket_close($socket);


	// format it nicely
	$recv = explode(chr(0), $buf, 2);
	$info = [];
	foreach (array_chunk(explode(';', rtrim($recv[1], ';')), 2) as $pair)
		$info[$pair[0]] = $pair[1];


	//For Debug
	//var_dump($info);
	//$correctServer = $host . ',' . $info['tcp']; // 192.168.12.34,49161
	//var_dump($correctServer);
	
	return $info['tcp'];
}

function getHostPort($server, $port=null) {
	if( PHP_OS != 'WINNT'){
		$arrayExpode = explode('\\', $server);
		if(count($arrayExpode) > 1 ){
			list($host, $instance) = $arrayExpode;
			if( !empty($instance) && empty($port) ){
				$port = getPortSqlServer($host,$instance);
			}
		}
		if( !empty($port) ){
			$server = $server.','.$port;
		}
	}
	return $server;
}

function extensaoCarregada($extensao=null)
{
    if (!extension_loaded($extensao)) {
        echo '<li>'.$extensao.'</b>: <span class="vermelho">Não instalada</span></li>';
    } else {
        echo '<li>'.$extensao.'</b>: <span class="verde">Instalada.</span></li>';
    }
}

function info(){
	echo '<div id="instrucoes" class="main">';
	echo 'Versão Atual do PHP: ' . phpversion();
	echo '<br> Sistema Operacional: ' . PHP_OS;
	echo '</div>';
}

function listaExtensoesBanco(){
	echo '<h3><a href="javascript:toggleDiv(\'listaExtensoesBanco\');">Banco de dados</a></h3>';
	echo '<div id="listaExtensoesBanco" class="alert-box warning">';
	echo '<ul>';
	extensaoCarregada('pdo');
	extensaoCarregada('pdo_sqlite');
	extensaoCarregada('sqlite3');
	extensaoCarregada('pdo_sqlsrv');
    extensaoCarregada('sqlsrv');
    extensaoCarregada('pdo_mysql');
    extensaoCarregada('PDO_OCI');
    extensaoCarregada('PDO_ODBC');
    extensaoCarregada('pdo_pgsql');
    extensaoCarregada('pdo_sqlite');
	echo '</ul>';
	echo '</div>';
}

function listaExtensoesGerais(){
	echo '<h3><a href="javascript:toggleDiv(\'listaExtensoesGerais\');">Gerais</a></h3>';
	echo '<div id="listaExtensoesGerais" class="alert-box warning">';
	echo '<ul>';
	extensaoCarregada('mbstring');
	extensaoCarregada('gd');
	extensaoCarregada('soap');
	extensaoCarregada('xml');
	extensaoCarregada('xsl');
    extensaoCarregada('SimpleXML');
    extensaoCarregada('zip');
    extensaoCarregada('ldap');
    extensaoCarregada('json');
    extensaoCarregada('curl');    
	echo '</ul>';
	echo '</div>';
}

function listaExtensoes(){
	echo '<hr>';
	echo '<h2><a href="javascript:toggleDiv(\'listaExtensoes\');">Extensões PHP</a></h2>';
	echo '<div id="listaExtensoes">';
	listaExtensoesBanco();
	listaExtensoesGerais();
	echo '</div>';
}

function showLink($link,$texto=null){
    $texto = empty($texto)?$link:$texto;
    echo '<a href="'.$link.'">'.$texto.'</a>';
}

function showLinkH16($idDiv,$texto,$h){
    echo '<h'.$h.'><a href="javascript:toggleDiv(\''.$idDiv.'\');">'.$texto.'</a></h'.$h.'>';
}

function infoDatabaseSqlServer($servidor,$banco,$usuario,$senha,$sql){
	echo '<br>';
	echo '<br>Teste Conect SQL Server';
	echo '<br>servidor: '.$servidor;
	echo '<br>banco: '.$banco;
	echo '<br>usuario: '.$usuario;
	echo '<br>senha: '.$senha;
	echo '<hr>';
	
	showLinkH16('infoPdo','Info PDO',3);
	
	echo '<div id="infoPdo">';
	$conn = new PDO('sqlsrv:Server='.$servidor.';Database='.$banco, $usuario, $senha);
    $conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );  
	
    echo '<pre>';
    echo "<br>PDO Drives: ";
    print_r(PDO::getAvailableDrivers());  
    //https://www.php.net/manual/pt_BR/pdo.setattribute.php
    echo '<br>';showLink('https://www.php.net/manual/pt_BR/pdo.setattribute.php');
    echo '<br>';showLink('https://www.php.net/manual/pt_BR/class.pdoexception.php');
    echo '<br>';showLink('https://www.php.net/manual/pt_BR/pdostatement.fetch.php');
    $attributes = array( 'DRIVER_NAME'
                        ,'CLIENT_VERSION'
                        ,'CASE'
                        ,'ERRMODE'
                        ,'DEFAULT_FETCH_MODE'
                        ,'SERVER_INFO'
                        ,'SERVER_VERSION'
                    );
    foreach ( $attributes as $val ) {  
        $valor = $conn->getAttribute( constant( "PDO::ATTR_$val" ) );
        echo "<br>PDO::ATTR_$val: ";  print_r($valor);
    }

    //https://docs.microsoft.com/pt-br/sql/connect/php/pdo-setattribute?view=sql-server-ver15
    echo '<br>';echo '<br>';showLink('https://docs.microsoft.com/pt-br/sql/connect/php/pdo-setattribute?view=sql-server-ver15');
    $attributes = array('CLIENT_BUFFER_MAX_KB_SIZE'
                       ,'DECIMAL_PLACES'
                       ,'DIRECT_QUERY'
                       ,'ENCODING'
                       ,'FETCHES_NUMERIC_TYPE'
                       ,'QUERY_TIMEOUT'
                    );  
    foreach ( $attributes as $val ) {  
        $valor = $conn->getAttribute( constant( "PDO::SQLSRV_ATTR_$val" ) );
        echo "<br>PDO::SQLSRV_ATTR_$val: ";  print_r($valor);
    }
    echo '</pre>';
	echo '</div>';
    echo '<hr>';
	showLinkH16('selectResult','Select Result',3);
	echo '<div id="selectResult">';
    var_dump($sql);
    $stmt = $conn->query($sql);
    $result = $stmt->fetchall(PDO::FETCH_ASSOC);
    var_dump($result);
	echo '</div>';
}

function testSqlServer(){
	echo '<hr>';
	showLinkH16('testSqlServer','Teste Drive SqlServer',2);

	$hostname = "nome_host";
	//$hostname = "10.34.250.34";
	//$hostname = "vp1-bd-001";
	$servidor = getHostPort($hostname);
	$banco    = "nome_banco";
	$usuario  = "string_usuario";
	$senha    = "string_senha";

    $sql = 'select *
    from dbo.tabela as t';

	echo '<div id="testSqlServer">';
    infoDatabaseSqlServer($servidor,$banco,$usuario,$senha,$sql);
	echo '</div>';
}
?>

<!DOCTYPE html>
<html lang="pt-br">
   <head>
       <meta charset="utf-8"/>
       <title>Test PHP com Sql Server</title>
	   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	   <style type="text/css">
			.main {
				font-size: 15px;
				font-family: Verdana,Geneva,Tahoma,Arial,Helvetica,sans-serif;
			}
			
			#instrucoes{
				padding: 0.2%;
				width: auto;
				background-color: #F1F1F1;
				border-radius: 4px;
				border: 1px solid #EDEDED;
			}	
			
			#exemplo{
				display: none;
				padding: 0.2%;
				width: auto;
				background-color: #E0F0BA;
				border-radius: 4px;
				border: 1px solid #EDEDED;		
			}
			
			#changelog{
				display: none;		
			}
			
			.alert-box {
				color:#555;
				border-radius:10px;
				font-family:Tahoma,Geneva,Arial,sans-serif;font-size:11px;
				padding:10px 10px 10px 36px;
				margin:10px;
			}

			.warning {
				background:#fff8c4 no-repeat 10px 50%;
				border:1px solid #f2c779;
			}

			.success {
				background:#e9ffd9 no-repeat 10px 50%;
				border:1px solid #a6ca8a;
			}

			.notice {
				background:#e3f7fc no-repeat 10px 50%;
				border:1px solid #8ed9f6;
			}

			.vermelho {
				color:#ff0000;
				font-weight:bold;
			}
			.verde {
				color:#008000;
				font-weight:bold;
			}
			.versao {
				color:#0000FF;
				font-weight:bold;
				font-size:16px;
			}
			ul {
				-webkit-column-count: 3;
				-moz-column-count: 3;
				column-count: 3;
			}
	   </style>
	   <script>
		function toggleDiv(divId) {
			$("#"+divId).toggle();
		}
		</script>
   </head>
   <body>
	   <h1>Test PHP com Sql Server</h1>
       <?php 
	   info();
	   listaExtensoes();
	   testSqlServer();
	   ?>
   </body>
</html>
