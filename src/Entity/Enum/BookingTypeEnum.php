<?php

namespace App\Entity\Enum;

enum BookingTypeEnum: string
{
    case PRIVATE = "privé";
    case SHARED = "partagé";
    case OTHER = "Autre";

    public function getLabel(): string
    {
        return BookingTypeEnum::getLabel($this);
    }
}
