<?php

namespace App\Services;

use App\Entity\BaggageTypes;
use Doctrine\ORM\EntityManagerInterface;

class TypesBaggageService
{
    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    /**
     * Retourne tous les types actifs
     * @return array|object[]|BaggageTypes[]
     */
    public function getAllIsActive(): array
    {
        return $this->entityManager->getRepository(BaggageTypes::class)->findBy(["active" => true]);
    }
}