<?php
require_once 'install/tools.php';

$code = '735utf8PHP7';
$filename = 'formDin';
if (file_exists($filename)) {
    header('Location: form.php');
} else {
    header('Location: install/index.php?cod='.$code);
}
?>