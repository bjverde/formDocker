<?php
if ( !function_exists( 'install_autoload') ) {
	function install_autoload( $class_name )	{
		require_once $class_name . '.class.php';
	}
spl_autoload_register('install_autoload');
}