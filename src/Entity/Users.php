<?php

namespace App\Entity;

use App\Entity\Enum\EnumUserStatus;
use App\Repository\UsersRepository;
use App\Validators\UniqueEmail;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: UsersRepository::class)]
#[UniqueEntity(fields: ['email'], message: 'There is already an account with this email')]
class Users implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 70)]
    #[Assert\Length(min: 1, max: 70)]
    private ?string $last_name = null;

    #[ORM\Column(length: 70)]
    #[Assert\Length(min: 1, max: 70)]
    private ?string $first_name = null;
    #[ORM\Column(length: 20)]
    #[Assert\Length(min: 10, max: 20)]
    #[Assert\Regex(
        pattern: "/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/",
        message: "Veuillez utilisez un numéro de téléphone valable",
        htmlPattern: "^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$"
    )]
    private ?string $phone = null;


    private ?string $countryCode;

    #[ORM\Column(length: 100, unique: true)]
    #[Assert\Email(message: "l'email doit être valide")]
    #[UniqueEmail(groups: ['registration', 'admin'])]
    private ?string $email = null;

    #[ORM\Column(length: 255)]
    #[Assert\Regex(
        pattern: "/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/",
        message: "Le mot de passe doit contenir 1 majuscule, 1 minuscule, 1 nombre et 1 caractère spécial.",
        htmlPattern: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$",
        groups: ['registration', 'admin'])]
    #[Assert\Length(
        min: 8,
        exactMessage: "Le mot de passe doit contenir 8 caractères minimum",
        groups: ['registration', 'admin'])]
    private ?string $password = null;

    #[Assert\EqualTo(
        propertyPath: 'password',
        message: "Les mots de passe doivent être identiques",
        groups: ['registration', 'admin'])]
    private ?string $confirmPassword = null;


    #[ORM\Column(type: "string", length: 25, enumType: EnumUserStatus::class)]
    private ?EnumUserStatus $userStatusEnum;

    #[ORM\Column]
    private ?bool $active = true;

    #[ORM\Column]
    private ?bool $resetPassword = true;

    #[ORM\ManyToOne(inversedBy: 'users')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Roles $role = null;

    #[ORM\ManyToOne(inversedBy: 'users')]
    #[ORM\JoinColumn(nullable: true)]
    private ?Addresses $Address = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLastName(): ?string
    {
        return $this->last_name;
    }

    public function setLastName(string $last_name): self
    {
        $this->last_name = $last_name;

        return $this;
    }

    public function getFirstName(): ?string
    {
        return $this->first_name;
    }

    public function setFirstName(string $first_name): self
    {
        $this->first_name = $first_name;

        return $this;
    }


    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(string $phone): self
    {
        $this->phone = $phone;

        return $this;
    }

    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    public function getConfirmPassword(): ?string
    {
        return $this->confirmPassword;
    }

    public function setConfirmPassword(?string $confirmPassword): void
    {
        $this->confirmPassword = $confirmPassword;
    }

    public function getUserStatus(): EnumUserStatus
    {
        return $this->userStatusEnum;
    }

    public function getUserStatusEnum(): ?EnumUserStatus
    {
        return $this->userStatusEnum;
    }

    public function setUserStatusEnum(?EnumUserStatus $userStatusEnum): self
    {
        $this->userStatusEnum = $userStatusEnum;
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

    public function getRole(): ?Roles
    {
        return $this->role;
    }

    public function setRole(?Roles $role): self
    {
        $this->role = $role;

        return $this;
    }

    public function getAddress(): ?Addresses
    {
        return $this->Address;
    }

    public function setAddress(?Addresses $Address): self
    {
        $this->Address = $Address;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getStreetName(): ?string
    {
        return $this->streetName;
    }

    /**
     * @param string|null $streetName
     */
    public function setStreetName(?string $streetName): void
    {
        $this->streetName = $streetName;
    }

    /**
     * @return string|null
     */
    public function getStreetNumber(): ?string
    {
        return $this->streetNumber;
    }

    /**
     * @param string|null $streetNumber
     */
    public function setStreetNumber(?string $streetNumber): void
    {
        $this->streetNumber = $streetNumber;
    }

    /**
     * @return string|null
     */
    public function getBoxNumber(): ?string
    {
        return $this->boxNumber;
    }

    /**
     * @param string|null $boxNumber
     */
    public function setBoxNumber(?string $boxNumber): void
    {
        $this->boxNumber = $boxNumber;
    }

    /**
     * @return string|null
     */
    public function getZipCode(): ?string
    {
        return $this->zipCode;
    }

    /**
     * @param string|null $zipCode
     */
    public function setZipCode(?string $zipCode): void
    {
        $this->zipCode = $zipCode;
    }

    /**
     * @return string|null
     */
    public function getCity(): ?string
    {
        return $this->city;
    }

    /**
     * @param string|null $city
     */
    public function setCity(?string $city): void
    {
        $this->city = $city;
    }

    /**
     * @return Countries|null
     */
    public function getCountry(): ?Countries
    {
        return $this->country;
    }

    /**
     * @param Countries|null $country
     */
    public function setCountry(?Countries $country): void
    {
        $this->country = $country;
    }

    /**
     * @return string[]
     */
    public function getRoles(): array
    {
        return array('ROLE_' . strtoupper($this->role->getLabel()));
    }

    /**
     * @return mixed
     */
    public function eraseCredentials(): mixed
    {
        return null;
    }

    /**
     * @return string
     */
    public function getUserIdentifier(): string
    {
        return $this->getEmail();
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    /**
     * @return string|null
     */
    public function getCountryCode(): ?string
    {
        return $this->countryCode;
    }

    /**
     * @param string $countryCode
     */
    public function setCountryCode(string $countryCode): void
    {
        $this->countryCode = $countryCode;
    }

    public function isResetPassword(): ?bool
    {
        return $this->resetPassword;
    }

    public function setResetPassword(?bool $resetPassword): void
    {
        $this->resetPassword = $resetPassword;
    }
}
