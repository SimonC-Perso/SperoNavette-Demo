<?php

namespace App\Services;

use App\Entity\Prices;
use App\Entity\PricesHistories;
use Doctrine\ORM\EntityManagerInterface;

class PricesHistoryService
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

    public function findById(mixed $id)
    {
        return $this->entityManager->getRepository(PricesHistories::class)->find($id);
    }

    public function getPriceHistories(Prices|null $price)
    {
        return $this->entityManager->getRepository(PricesHistories::class)->findHistoriesByPriceId($price->getId());
    }

}