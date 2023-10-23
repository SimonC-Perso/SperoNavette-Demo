<?php

namespace App\Entity;

use App\Repository\AddressesRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AddressesRepository::class)]
class Addresses
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $street_name = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $street_number = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $box_number = null;

    #[ORM\ManyToOne]
    #[ORM\JoinColumn(nullable: false)]
    private ?Cities $city = null;

    #[ORM\OneToMany(mappedBy: 'Addresses', targetEntity: Users::class)]
    private Collection $users;

    public function __construct()
    {
        $this->users = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(?int $id): void
    {
        $this->id = $id;
    }

    public function getStreetName(): ?string
    {
        return $this->street_name;
    }

    public function setStreetName(?string $street_name): void
    {
        $this->street_name = $street_name;
    }

    public function getStreetNumber(): ?string
    {
        return $this->street_number;
    }

    public function setStreetNumber(?string $street_number): void
    {
        $this->street_number = $street_number;
    }

    public function getBoxNumber(): ?string
    {
        return $this->box_number;
    }

    public function setBoxNumber(?string $box_number): void
    {
        $this->box_number = $box_number;
    }

    public function getCity(): ?Cities
    {
        return $this->city;
    }

    public function setCity(?Cities $city): void
    {
        $this->city = $city;
    }

    public function getUsers(): Collection
    {
        return $this->users;
    }

    public function setUsers(Collection $users): void
    {
        $this->users = $users;
    }

}
