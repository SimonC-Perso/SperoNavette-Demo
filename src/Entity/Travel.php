<?php

namespace App\Entity;

use App\Repository\TravelsRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: TravelsRepository::class)]
class Travel
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(name: 'starting_address', nullable: false)]
    private ?Addresses $startingAddress = null;

    #[ORM\ManyToOne(cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(name: 'arrival_address', nullable: false)]
    private ?Addresses $arrivalAddress = null;

    #[ORM\OneToOne(inversedBy: 'travel', targetEntity: self::class, cascade: ['persist', 'remove'])]
    private ?self $step = null;

    #[ORM\OneToOne(mappedBy: 'step', targetEntity: self::class, cascade: ['persist', 'remove'])]
    private ?self $travel = null;


    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStartingAddress(): ?Addresses
    {
        return $this->startingAddress;
    }

    public function setStartingAddress(?Addresses $startingAddress): void
    {
        $this->startingAddress = $startingAddress;
    }

    public function getArrivalAddress(): ?Addresses
    {
        return $this->arrivalAddress;
    }

    public function setArrivalAddress(?Addresses $arrivalAddress): void
    {
        $this->arrivalAddress = $arrivalAddress;
    }

    public function getPreviousTravel(): ?self
    {
        return $this->travel;
    }

    public function setPreviousTravel(?self $travel): self
    {
        // unset the owning side of the relation if necessary
        if ($travel === null && $this->travel !== null) {
            $this->travel->setStep(null);
        }

        // set the owning side of the relation if necessary
        if ($travel !== null && $travel->getStep() !== $this) {
            $travel->setStep($this);
        }

        $this->travel = $travel;

        return $this;
    }

    public function getStep(): ?self
    {
        return $this->step;
    }

    public function setStep(?self $step): self
    {
        $this->step = $step;

        return $this;
    }

}
