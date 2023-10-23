<?php

namespace App\Entity;

use App\Repository\BaggagesRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: BaggagesRepository::class)]
class Baggage
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $label = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $price = null;

    #[ORM\Column(name: 'is_active')]
    private ?bool $active = null;

    #[ORM\ManyToOne(inversedBy: 'baggage')]
    #[ORM\JoinColumn(name: 'baggage_types', nullable: false)]
    private ?BaggageTypes $baggageTypes = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLabel(): ?string
    {
        return $this->label;
    }

    public function getPrice(): ?string
    {
        return $this->price;
    }

    public function setPrice(?string $price): void
    {
        $this->price = $price;
    }

    public function isActive(): ?bool
    {
        return $this->active;
    }

    public function setActive(?bool $active): void
    {
        $this->active = $active;
    }

    public function getBaggageTypes(): ?BaggageTypes
    {
        return $this->baggageTypes;
    }

    public function setBaggageTypes(?BaggageTypes $baggageTypes): void
    {
        $this->baggageTypes = $baggageTypes;
    }

}
