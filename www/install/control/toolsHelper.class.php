<?php

class toolsHelper
{

    /**
     * Similar to array_key_exists. But it does not generate an error message
     *
     * Semelhante ao array_key_exists. Mas não gera mensagem de erro
     *
     * @param  string $atributeName
     * @param  array  $array
     * @return boolean
     */
    public static function has($atributeName,$array) 
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
    public static function getDefaultValeu($array,$atributeName,$DefaultValue) 
    {
        $value = $DefaultValue;
        if(self::has($atributeName, $array) ) {
            if(isset($array[$atributeName]) && ($array[$atributeName]<>'') ) {
                $value = $array[$atributeName];
            }
        }
        return $value;
    }


     /**
     * https://stackoverflow.com/questions/6768793/get-the-full-url-in-php
     *
     * @param  boolean $trim_query_string
     * @return string|mixed
     */
    public static function getServer() 
    {
        $pageURL = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? "https://" : "http://";
        $pageURL = $pageURL.$_SERVER["SERVER_NAME"];
        $pageURL = $pageURL.( ( $_SERVER["SERVER_PORT"] != 80 ) ? ":".$_SERVER["SERVER_PORT"] : "") ;
        $pageURL = $pageURL.'/';
        return $pageURL;
    }

    public static function getUrlOnServer($path) 
    {
        $pageURL = self::getServer();
        return $pageURL.$path;
    }

    public static function showHref($url,$text) 
    {
        $fullUrl = self::getUrlOnServer($url);
        echo '<a href="'.$fullUrl.'" target="_blank">'.$text.'</a>';
        //<a href="http://localhost/formDin/appexemplo_form_alone" target="_blank">Formulario simples apenas mostrando informações</a>
    }
}