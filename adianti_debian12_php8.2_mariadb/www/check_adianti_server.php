<?php
function phpModulo($extensao=null, $html=null)
{
    if (!extension_loaded($extensao)) {
        $html->add('<b>'.$extensao.'</b>: <span class="vermelho">Não instalado</span><br>');
        return true;
    } else {
        $html->add('<b>'.$extensao.'</b>: <span class="verde">Instalado</span><br>');
        return false;
    }
}
function apacheModulo($moduloApache){
    $listModulos = apache_get_modules();
    $result = in_array($moduloApache, $listModulos);
    return $result;
}
function extensaoCarregada($extensao=null){
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
    extensaoCarregada('ODBC');
    extensaoCarregada('pdo_pgsql');
    extensaoCarregada('pdo_sqlite');
	echo '</ul>';
	echo '</div>';
}
function listaExtensoesGerais(){
	echo '<h3><a href="javascript:toggleDiv(\'listaExtensoesGerais\');">Gerais</a></h3>';
	echo '<div id="listaExtensoesGerais" class="alert-box warning">';
	echo '<ul>';
    extensaoCarregada('curl');
	extensaoCarregada('gd');
    extensaoCarregada('json');
    extensaoCarregada('ldap');
	extensaoCarregada('mbstring');
    extensaoCarregada('SimpleXML');
	extensaoCarregada('soap');
	extensaoCarregada('xml');
	extensaoCarregada('xsl');
    extensaoCarregada('zip');
	echo '</ul>';
	echo '</div>';
}
function listaExtensoes(){
	echo '<hr>';
	echo '<h2>Extensões PHP</h2>';
	listaExtensoesBanco();
	listaExtensoesGerais();
}

?>

<!DOCTYPE html>
<html>
<!--
    <Exploding edict - This software is used to format string>
    Copyright (C) 2014  - Reinaldo A. Barrêto Jr - bjverde at yahoo.com.br

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->
<head>
<meta charset="UTF-8"/>
<title>Check Adianti Server</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
    body{
		font-size: 15px;
		font-family: Verdana,Geneva,Tahoma,Arial,Helvetica,sans-serif;
    }
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
		font-family:Tahoma,Geneva,Arial,sans-serif;
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
<h1>CheckList para Adianti FrameWork ou Adianti Template</h1>
</br>
</br>Baseado no artigo <a href="https://www.adianti.com.br/forum/pt/view_7397?preparando-um-servidor-gabarito-para-o-adianti-framework-com-ubuntu-2204-e-php-81" target="_blank">Preparando um servidor gabarito para o Adianti Framework (com Ubuntu 22.04 e PHP 8.1)</a> do Pablo Dall'Oglio
</br>
</br>
<?php
    info();
    listaExtensoes();
?>
</html>