<?php
define('DS'   , DIRECTORY_SEPARATOR);

require_once ('vendor/autoload.php');
require_once ('control/autoload_install.php');

function updateConfigFormAppExemplo(){
    $pathOld = '/var/www/html/install/config/config_conexao.php';
    $pathNew = '/var/www/html/formDin/appexemplo_v2.0/includes/config_conexao.php';
    unlink($pathNew);
    copy($pathOld, $pathNew);

    $pathNew = '/var/www/html/formDin/appexemplo_v2.5/includes/config_conexao.php';
    unlink($pathNew);
    copy($pathOld, $pathNew);
}
function updateDataBase(){
    //$serverName = $_SERVER["SERVER_NAME"];
    $serverName = 'mysql';
    $filename = '/var/www/html/formDin/modelo_banco_exemplos/01_script_criacao_banco.sql';
    importDb::exec($filename,$serverName);

    $filename = '/var/www/html/formDin/modelo_banco_exemplos/02_script_inclusao_dados.sql';
    importDb::exec($filename,$serverName);
}
function installFormDin(){
    header('Content-Type: text/html; charset=utf-8');
    $filename = '/var/www/install_base_formdin.sh';
    if (!file_exists($filename)) {
        echo "Falha na construção da imagem docker";
    } else {
        if(empty($_POST)){
            require_once 'aviso.php';
        }else{
            files::copyFormDin2Apache();
            updateConfigFormAppExemplo();
            echo "<h2>Copia formDin Completa! \o/ Yeeeee !!</h2>";
            updateDataBase();
            echo "<h2>Bando de Dados Atualizado!</h2>";
            echo "<br>";
            echo '<form name="form" method="post" action="../index.php">'; 
            echo '<button type="submit">Recarregar</button>';
            echo '</form>';            
        }
    }    
}

$filename = 'formDin';
if (file_exists($filename)) {
    header('Location: ../form.php');
} else { 
    $code = toolsHelper::getDefaultValeu($_GET,'cod',null);
    if( $code =='735utf8PHP7' ){
        installFormDin();
    }else{
        header('Location: ../index.php');
    }
}
?>