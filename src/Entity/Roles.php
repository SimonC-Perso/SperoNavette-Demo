<?php

namespace App\Entity;

use App\Repository\RolesRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: RolesRepository::class)]
class Roles
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $label = null;

    #[ORM\OneToMany(mappedBy: 'role_id', targetEntity: RolesAuthorizations::class)]
    private Collection $rolesAuthorizations;

    #[ORM\OneToMany(mappedBy: 'role_id', targetEntity: Users::class)]
    private Collection $users;

    public function __construct()
    {
        $this->rolesAuthorizations = new ArrayCollection();
        $this->users = new ArrayCollection();
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
            $rolesAuthorization->setRoleId($this);
        }

        return $this;
    }

    public function removeRolesAuthorization(RolesAuthorizations $rolesAuthorization): self
    {
        if ($this->rolesAuthorizations->removeElement($rolesAuthorization)) {
            // set the owning side to null (unless already changed)
            if ($rolesAuthorization->getRoleId() === $this) {
                $rolesAuthorization->setRoleId(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Users>
     */
    public function getUsers(): Collection
    {
        return $this->users;
    }

    public function addUser(Users $user): self
    {
        if (!$this->users->contains($user)) {
            $this->users->add($user);
            $user->setRole($this);
        }

        return $this;
    }

    public function removeUser(Users $user): self
    {
        if ($this->users->removeElement($user)) {
            // set the owning side to null (unless already changed)
            if ($user->getRole() === $this) {
                $user->setRole(null);
            }
        }

        return $this;
    }
}
