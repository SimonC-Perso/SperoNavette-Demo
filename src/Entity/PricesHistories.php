<?php

namespace App\Entity;

use App\Repository\PricesHistoryRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: PricesHistoryRepository::class)]
class PricesHistories
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(name: 'begin_date', type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $beginDate = null;

    #[ORM\Column(name: 'end_date', type: Types::DATETIME_MUTABLE, nullable: true)]
    private ?\DateTimeInterface $endDate = null;

    #[ORM\Column(name: 'previous_price', type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?int $previousPrice = null;

    #[ORM\ManyToOne(inversedBy: 'pricesHistories')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Prices $price = null;


    public function __construct()
    {
    }


    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(?int $id): void
    {
        $this->id = $id;
    }


    public function getBeginDate(): ?\DateTimeInterface
    {
        return $this->beginDate;
    }

    public function setBeginDate(?\DateTimeInterface $beginDate): void
    {
        $this->beginDate = $beginDate;
    }

    public function getEndDate(): ?\DateTimeInterface
    {
        return $this->endDate;
    }

    public function setEndDate(?\DateTimeInterface $endDate): void
    {
        $this->endDate = $endDate;
    }

    public function getPreviousPrice(): ?int
    {
        return $this->previousPrice;
    }

    public function setPreviousPrice(?int $previousPrice): void
    {
        $this->previousPrice = $previousPrice;
    }

    public function getPrice(): ?Prices
    {
        return $this->price;
    }

    public function setPrice(?Prices $price): void
    {
        $this->price = $price;
    }

}
