<?php
require_once 'tools.php';

$code = '735utf8PHP7';
$filename = 'formDin';
if (file_exists($filename)) {
    header('Location: form.php');
} else {
    header('Location: install.php?cod='.$code);
}
?>