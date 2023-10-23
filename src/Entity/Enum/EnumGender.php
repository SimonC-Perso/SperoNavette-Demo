<?php

namespace App\Entity\Enum;

enum EnumGender:string
{
    case Homme ="Mr.";
    case Femme="Mme.";
    case Indetermine = "Autre";

    public function getLabel():string{
        return static::getLabel($this);
    }
}
