<?php

namespace App\Services;

use App\Entity\Addresses;
use App\Entity\Airports;
use App\Entity\Cities;
use Doctrine\ORM\EntityManagerInterface;

class CitiesService
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
    public function findCityById($id)
    {
        return $this->entityManager->getRepository(Cities::class)->find($id);

    }
}