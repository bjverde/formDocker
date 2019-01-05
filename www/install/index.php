<?php
define('DS'   , DIRECTORY_SEPARATOR);

require_once ('vendor/autoload.php');
require_once ('control/autoload_install.php');

function updateDataBase(){
    $serverName = $_SERVER["SERVER_NAME"];
    //$filename = '/var/www/html/formDin/modelo_banco_exemplos/01_script_criacao_banco.sql';
    $filename = '/var/www/html/modelo_banco_exemplos/01_script_criacao_banco.sql';
    importDb::exec($filename,$serverName);
    //$filename = '/var/www/html/formDin/modelo_banco_exemplos/02_script_inclusao_dados.sql';
    $filename = '/var/www/html/modelo_banco_exemplos/02_script_inclusao_dados.sql';
    importDb::exec($filename,$serverName);
}
function installFormDin(){
    header('Content-Type: text/html; charset=utf-8');
    //echo "<h2>A Instalação não está completa !! Processo em construção </h2>";
    $filename = '/var/www/install_base_formdin.sh';
    if (!file_exists($filename)) {
        echo "Falha na construção da imagem docker";
    } else {
        if(empty($_POST)){
            echo "<h2>A Instalação não está completa !! Mas estamos quase lá ;-) </h2>";
            echo "<br>";
            echo "<br>A copia do formDin será colocada na pasta WWW dentro do volume ou /var/www/html no Docker.";
            echo "<br>";
            echo "<br>Se estiver no Linux é recomendavel deixar a pasta WWW do volume com a permisão 777";
            echo "<br>";
            echo "<br>Se estiver usado o <a href='https://github.com/bjverde/formDin/wiki/Usando-o-VS-Code'>VS Code poderá usar X-Debug com conexão remota</a>";           
            echo '<form name="form" method="post">'; 
            echo '<button name="baixar" value="baixar" type="submit">Continuar a instalação</button>';
            echo '</form>';
        }else{
            //files::copyFormDin2Apache();
            echo "<h2>Copia formDin Completa! \o/ Yeeeee !!</h2>";
            updateDataBase();
            echo "<h2>Bando de Dados Atualizado!</h2>";
            echo "<br>";
            echo '<form name="form" method="post">'; 
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