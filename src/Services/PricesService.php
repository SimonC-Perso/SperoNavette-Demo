<?php

namespace App\Services;

use App\Entity\Prices;
use App\Entity\PricesHistories;
use Doctrine\ORM\EntityManagerInterface;

class PricesService
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
    public function getTravelPrices($from, $to): ?Prices
    {
        return $this->entityManager->getRepository(Prices::class)->findByFormIdToId($from, $to);
    }

    public function findById(mixed $id)
    {
        return $this->entityManager->getRepository(Prices::class)->find($id);
    }

    public function getPriceHistories(Prices|null $price)
    {
        return $this->entityManager->getRepository(PricesHistories::class)->findHistoriesByPriceId($price->getId());
    }

}