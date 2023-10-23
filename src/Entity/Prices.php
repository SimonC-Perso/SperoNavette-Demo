<?php

namespace App\Entity;

use App\Repository\PricesRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: PricesRepository::class)]
class Prices
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;


    #[ORM\Column(name: 'price', type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?float $price = null;

    #[ORM\Column(name: 'date', type: Types::DATETIME_MUTABLE, options: ['default' => 'CURRENT_TIMESTAMP'])]
    private ?\DateTimeInterface $date = null;

    #[ORM\ManyToOne(inversedBy: 'from')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Cities $from = null;

    #[ORM\ManyToOne(inversedBy: 'to')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Cities $to = null;


    public function __construct()
    {
        $this->pricesHistories = new ArrayCollection();
        $this->date = new \DateTimeImmutable();
    }


    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(?int $id): void
    {
        $this->id = $id;
    }

    public function getFrom(): ?Cities
    {
        return $this->from;
    }

    public function setFrom(?Cities $from): void
    {
        $this->from = $from;
    }

    public function getTo(): ?Cities
    {
        return $this->to;
    }

    public function setTo(?Cities $to): void
    {
        $this->to = $to;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(?\DateTimeInterface $date): void
    {
        $this->date = $date;
    }


    public function getPrice(): ?float
    {
        return $this->price;
    }

    public function setPrice(?float $price): void
    {
        $this->price = $price;
    }


}
