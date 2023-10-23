<?php

namespace App\Entity\Enum;

enum EnumUserStatus: string
{
    case Ok = 'Ok';
    case Blacklist = 'Blacklist';

    public function getLabel(): string
    {
        return EnumUserStatus::getLabel($this);
    }
}
