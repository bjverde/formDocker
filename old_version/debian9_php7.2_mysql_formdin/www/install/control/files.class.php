<?php

class files
{
    const PATHOLD = '/opt/formDin';
    const PATHNEW = '/var/www/html/formDin';

    public static function mkDir($path)
    {
        if (!is_dir($path)) {
            mkdir($path, 0777, true);
        }
    }

    public static function copyFormDin2Apache()
    {
        $pathNew = self::PATHNEW;
        $pathOld = self::PATHOLD;
        self::mkDir($pathNew);

        $list = new RecursiveDirectoryIterator($pathOld);
        $it   = new RecursiveIteratorIterator($list);
        
        foreach ($it as $file) {
            if ($it->isFile()) {
                //echo ' SubPathName: ' . $it->getSubPathName();
                //echo ' SubPath:     ' . $it->getSubPath()."<br>";
                self::mkDir($pathNew.DS.$it->getSubPath());
                copy($pathOld.DS.$it->getSubPathName(), $pathNew.DS.$it->getSubPathName());
                chmod ($pathNew.DS.$it->getSubPathName(), 0777);
            }
        }
    }
}