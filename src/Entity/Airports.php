<?php

namespace App\Entity;

use App\Repository\AirportsRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AirportsRepository::class)]
class Airports
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $label = null;

    #[ORM\Column]
    private ?bool $active = true;

    #[ORM\ManyToOne (inversedBy: "airports")]
    #[ORM\JoinColumn(name: 'addresse_id', nullable: false)]
    private ?Addresses $addresse = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLabel(): ?string
    {
        return $this->label;
    }

    public function getActive(): ?bool
    {
        return $this->active;
    }

    public function setActive(?bool $active): void
    {
        $this->active = $active;
    }

    public function getAddresse(): ?Addresses
    {
        return $this->addresse;
    }

    public function setAddresse(?Addresses $addresse): void
    {
        $this->addresse = $addresse;
    }

}
