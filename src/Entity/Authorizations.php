<?php

namespace App\Entity;

use App\Repository\AuthorizationsRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AuthorizationsRepository::class)]
class Authorizations
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $label = null;

    #[ORM\OneToMany(mappedBy: 'authorization', targetEntity: RolesAuthorizations::class)]
    private Collection $rolesAuthorizations;

    public function __construct()
    {
        $this->rolesAuthorizations = new ArrayCollection();
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

    /**
     * @return Collection<int, RolesAuthorizations>
     */
    public function getRolesAuthorizations(): Collection
    {
        return $this->rolesAuthorizations;
    }

    public function addRolesAuthorization(RolesAuthorizations $rolesAuthorization): self
    {
        if (!$this->rolesAuthorizations->contains($rolesAuthorization)) {
            $this->rolesAuthorizations->add($rolesAuthorization);
            $rolesAuthorization->setAuthorization($this);
        }

        return $this;
    }

    public function removeRolesAuthorization(RolesAuthorizations $rolesAuthorization): self
    {
        if ($this->rolesAuthorizations->removeElement($rolesAuthorization)) {
            // set the owning side to null (unless already changed)
            if ($rolesAuthorization->getAuthorization() === $this) {
                $rolesAuthorization->setAuthorization(null);
            }
        }

        return $this;
    }
}
