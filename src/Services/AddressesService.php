<?php

namespace App\Services;

use App\Entity\Addresses;
use App\Entity\Airports;
use Doctrine\ORM\EntityManagerInterface;

class AddressesService
{
    private $entityManager;
    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    /**
     * Retourne une adresse avec une rue, limit 6
     * @param $streetName
     * @return mixed
     */
    public function checkByStreetName($streetName){
         return $this->entityManager->getRepository(Addresses::class)->findByStreetName($streetName);

    }
}