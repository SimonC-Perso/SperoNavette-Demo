<?php

namespace App\Services;

use App\Entity\Baggage;
use Doctrine\ORM\EntityManagerInterface;

class BaggageService
{
    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    /**
     * retourne les baggage actifs en fonction du filtre
     * @param $filter
     * @return void
     */
    public function getAllBaggageByFilter($filter): array
    {
        return $this->entityManager->getRepository(Baggage::class)->findByFilter($filter);
    }
}