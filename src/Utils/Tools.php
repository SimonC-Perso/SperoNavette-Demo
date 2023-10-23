<?php

namespace App\Utils;

class Tools
{
    static function startsWith($string, $startString)
    {
        $len = strlen($startString);
        foreach ($string as $value) {
            if (substr($value, 0, $len) === $startString)
                return true;
        }
        return false;
    }
}