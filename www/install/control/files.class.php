<?php

class files
{

    public static function mkDir($path)
    {
        if (!is_dir($path)) {
            mkdir($path, 0744, true);
        }
    }

    public static function copySystemSkeletonToNewSystem()
    {
        $pathNewSystem = self::getPathNewSystem();
        $pathSkeleton  = 'system_skeleton';
        
        $list = new RecursiveDirectoryIterator($pathSkeleton);
        $it   = new RecursiveIteratorIterator($list);
        
        foreach ($it as $file) {
            if ($it->isFile()) {
                //echo ' SubPathName: ' . $it->getSubPathName();
                //echo ' SubPath:     ' . $it->getSubPath()."<br>";
                self::mkDir($pathNewSystem.DS.$it->getSubPath());
                copy($pathSkeleton.DS.$it->getSubPathName(), $pathNewSystem.DS.$it->getSubPathName());
            }
        }
    }
}