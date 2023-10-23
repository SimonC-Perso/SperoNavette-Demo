<?php

namespace App\Entity;

use App\Repository\RolesAuthorizationsRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: RolesAuthorizationsRepository::class)]
class RolesAuthorizations
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $label = null;

    #[ORM\ManyToOne(inversedBy: 'rolesAuthorizations')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Roles $role = null;

    #[ORM\ManyToOne(inversedBy: 'rolesAuthorizations')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Authorizations $authorization = null;

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

    public function getRole(): ?Roles
    {
        return $this->role;
    }

    public function setRole(?Roles $role): void
    {
        $this->role = $role;
    }

    public function getAuthorization(): ?Authorizations
    {
        return $this->authorization;
    }

    public function setAuthorization(?Authorizations $authorization): void
    {
        $this->authorization = $authorization;
    }

}
