<?php

namespace App\Entity\Enum;

enum EnumBookingStatus: string
{
    case PENDING = 'En Attente';
    case REQUEST = 'Demande de devis';
    case ACCEPTED = 'Acceptée';
    case INPROGRESS = "En cours";
    case PAID = "Payée";
    case REFUSED = "Refusée";

    public function getLabel(): string
    {
        return EnumBookingStatus::getLabel($this);
    }
}
