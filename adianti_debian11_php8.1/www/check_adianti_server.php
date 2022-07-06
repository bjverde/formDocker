<?php

function phpModulo($extensao=null, $html)
{
    if (!extension_loaded($extensao)) {
        $html->add('<b>'.$extensao.'</b>: <span class="vermelho">Não instalada</span><br>');
        return true;
    } else {
        $html->add('<b>'.$extensao.'</b>: <span class="verde">Instalada.</span><br>');
        return false;
    }
}

function apacheModulo($moduloApache) 
{
    $listModulos = apache_get_modules();
    $result = in_array($moduloApache, $listModulos);
    return $result;
}




$frm = new TForm('Configurações do PHP');
    $frm->setFlat(true);
    $frm->setAutoSize(true);
    
    $html = $frm->addHtmlField('conf', '');
    $html->setCss('font-size', '14px');

    $html->add(info::phpVersionOK());
    $html->add('<b>Seu IP</b>: <span class="versao">'.$_SERVER['REMOTE_ADDR'].'</span><br>');

    $html->add('<br><b>Extensções:</b><br>');

    testar('gd', $html);
    testar('pdf', $html);

    $html->add('<br>');
    testar('pgsql', $html);
    testar('SQLite', $html);
    testar('sqlite3', $html);
    testar('odbc', $html);
    testar('mysql', $html);
    testar('interbase', $html);
    testar('oci8', $html);
    testar('sqlsrv', $html);

    $html->add('<br>');
    testar('pdo', $html);
    testar('PDO_Firebird', $html);
    $html->add(info::infoSQLServer()); testar('pdo_sqlsrv', $html);
    testar('pdo_mysql', $html);
    testar('PDO_OCI', $html);
    testar('PDO_ODBC', $html);
    testar('pdo_pgsql', $html);
    testar('pdo_sqlite', $html);

    $html->add('<br>');
    testar('soap', $html);
    testar('xml', $html);
    testar('SimpleXML', $html);
    testar('xsl', $html);
    testar('zip', $html);
    testar('zlib', $html);
    testar('ldap', $html);
    testar('json', $html);
    testar('curl', $html);

    $frm->show();