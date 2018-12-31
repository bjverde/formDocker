<?php

$filename = 'formDin';
if (file_exists($filename)) {
    header('Location: form.php');
} else {
    header('Location: install.php?cod=735utf8PHP7');
}
?>