<?php
define('DS'   , DIRECTORY_SEPARATOR);

require_once ('vendor/autoload.php');
require_once ('control/autoload_install.php');

function installFormDin(){
    header('Content-Type: text/html; charset=utf-8');
    //echo "<h2>A Instalação não está completa !! Processo em construção </h2>";
    $filename = '/var/www/install_base_formdin.sh';
    if (!file_exists($filename)) {
        echo "Falha na construção da imagem docker";
    } else {
        if(empty($_POST)){
            echo "<h2>A Instalação não está completa !! Mas estamos quase lá :-) </h2>";
            echo "<br>";
            echo "<br>Essa etapa pode demorar um pouco. Pode levar 3 a 5 minutos dependendo da velocidade da internet.";
            echo "<br>";
            echo "<br>Será preciso baixar e instalar o FormDin FrameWork PHP";
            echo "<br>";
            echo '<form name="form" method="post">'; 
            echo '<button name="baixar" value="baixar" type="submit">Continuar a instalação</button>';
            echo '</form>';
        }else{
            files::copyFormDin2Apache();
            //$output = shell_exec($filename);
            //echo "<pre>".var_dump($output)."</pre>";
            /*
            $return_var = null;
            exec ( $filename , $output , $return_var );        
            echo "<pre>".var_dump($output)."</pre>";
            echo "<pre>".var_dump($return_var)."</pre>";
            */
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