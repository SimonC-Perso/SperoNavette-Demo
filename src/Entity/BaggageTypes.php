<?php

namespace App\Entity;

use App\Repository\BaggageTypesRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: BaggageTypesRepository::class)]
class BaggageTypes
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $label = null;

    #[ORM\Column(name: 'is_active')]
    private ?bool $active = true;

    #[ORM\OneToMany(mappedBy: 'baggageTypes', targetEntity: Baggage::class)]
    private Collection $baggageList;

    public function __construct()
    {
        $this->baggageList = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLabel(): ?string
    {
        return $this->label;
    }

    public function setLabel(string $label): self
    {
        $this->label = $label;

        return $this;
    }

    public function isActive(): ?bool
    {
        return $this->active;
    }

    public function setActive(bool $active): self
    {
        $this->active = $active;

        return $this;
    }

    /**
     * @return Collection<int, Baggage>
     */
    public function getBaggageList(): Collection
    {
        return $this->baggageList;
    }

    public function addBaggage(Baggage $baggage): self
    {
        if (!$this->baggageList->contains($baggage)) {
            $this->baggageList->add($baggage);
            $baggage->setBaggageTypes($this);
        }

        return $this;
    }

    public function removeBaggage(Baggage $baggage): self
    {
        if ($this->baggageList->removeElement($baggage)) {
            // set the owning side to null (unless already changed)
            if ($baggage->getBaggageTypes() === $this) {
                $baggage->setBaggageTypes(null);
            }
        }

        return $this;
    }
}
