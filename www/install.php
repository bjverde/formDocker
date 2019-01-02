<?php

    /**
     * Similar to array_key_exists. But it does not generate an error message
     *
     * Semelhante ao array_key_exists. Mas não gera mensagem de erro
     *
     * @param  string $atributeName
     * @param  array  $array
     * @return boolean
     */
    function has($atributeName,$array) 
    {
        $value = false;
        if (is_array($array) && array_key_exists($atributeName, $array)) {
            $value = true;
        }
        return $value;
    }

    /***
     *
     * @param array  $array
     * @param string $atributeName
     * @param mixed  $DefaultValue
     * @return mixed
     */
    function getDefaultValeu($array,$atributeName,$DefaultValue) 
    {
        $value = $DefaultValue;
        if(has($atributeName, $array) ) {
            if(isset($array[$atributeName]) && ($array[$atributeName]<>'') ) {
                $value = $array[$atributeName];
            }
        }
        return $value;
    }


function installFormDin(){
    header('Content-Type: text/html; charset=utf-8');
    $filename = '/var/www/install_base_formdin.sh';
    if (!file_exists($filename)) {
        echo "Falha na construção da imagem docker";
    } else {
        if(empty($_POST)){
            echo "<h2>A Instalação não está completa !! Mas estamos quase lá :-) </h2>";
            echo "<br>";
            echo "<br>Essa etapa pode demorar um pouco. Será preciso baixar e instalar o FormDin FrameWork PHP";
            echo "<br>";
            echo '<form name="form" method="post">'; 
            echo '<button name="baixar" value="baixar" type="submit">Continuar a instalação</button>';
            echo '</form>';
        }else{
            //$output = shell_exec($filename);
            //echo "<pre>".var_dump($output)."</pre>";
            $return_var = null;
            exec ( $filename , $output , $return_var );        
            echo "<pre>".var_dump($output)."</pre>";
            echo "<pre>".var_dump($return_var)."</pre>";
            echo '<form name="form" method="post">'; 
            echo '<button type="submit">Recarregar</button>';
            echo '</form>';            
        }
    }
}

$filename = 'formDin';
if (file_exists($filename)) {
    header('Location: form.php');
} else { 
    $code = getDefaultValeu($_GET,'cod',null);
    if( $code =='735utf8PHP7' ){
        installFormDin();
    }else{
        header('Location: index.php');
    }
}
?>