<?php

namespace App\Entity;

use App\Entity\Enum\BookingTypeEnum;
use App\Entity\Enum\EnumBookingStatus;
use App\Entity\Enum\EnumReservationStatut;
use App\Repository\BookingRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: BookingRepository::class)]
class Booking
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(name: 'booking_date', type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $bookingDate = null;

    #[ORM\Column]
    private ?int $passenger = null;

    #[ORM\Column(name: 'departure_date', type: Types::DATETIME_MUTABLE, nullable: true)]
    private ?\DateTimeInterface $departureDate = null;

    #[ORM\Column(name: 'arrival_date', type: Types::DATETIME_MUTABLE, nullable: true)]
    private ?\DateTimeInterface $arrivalDate = null;

    #[ORM\Column(name: 'arrival_flight_number', length: 15, nullable: true)]
    private ?string $arrivalFlightNumber = null;

    #[ORM\Column(name: 'departure_flight_number', length: 15, nullable: true)]
    private ?string $departureFlightNumber = null;

    #[ORM\Column(name: 'total_price', type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $totalPrice = null;

    #[ORM\Column(name: 'booking_type_enum', enumType: BookingTypeEnum::class)]
    private ?BookingTypeEnum $bookingTypeEnum = null;

    #[ORM\Column(name: 'note', length: 500, nullable: true)]
    private ?string $note = null;

    #[ORM\Column(length: 255)]
    private ?EnumBookingStatus $status = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2, nullable: true)]
    private ?string $discount = null;

    #[ORM\Column(name: 'is_active')]
    private ?bool $active = null;
    #[ORM\ManyToOne (cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(name: 'travel', nullable: false)]
    private ?Travel $travel = null;

    #[ORM\ManyToOne]
    #[ORM\JoinColumn(nullable: true)]
    private ?Users $driver = null;

    #[ORM\ManyToOne]
    #[ORM\JoinColumn(nullable: true)]
    private ?Users $user = null;

    #[ORM\OneToMany(mappedBy: 'booking', targetEntity: Reports::class)]
    private Collection $reports;

    #[ORM\OneToMany(mappedBy: 'booking', targetEntity: BookingBaggage::class, cascade: ['persist', 'remove'])]
    private Collection $travelBaggageList;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(?int $id): void
    {
        $this->id = $id;
    }

    public function getBookingDate(): ?\DateTimeInterface
    {
        return $this->bookingDate;
    }

    public function setBookingDate(?\DateTimeInterface $bookingDate): void
    {
        $this->bookingDate = $bookingDate;
    }

    public function getPassenger(): ?int
    {
        return $this->passenger;
    }

    public function setPassenger(?int $passenger): void
    {
        $this->passenger = $passenger;
    }

    public function getDepartureDate(): ?\DateTimeInterface
    {
        return $this->departureDate;
    }

    public function setDepartureDate(?\DateTimeInterface $departureDate): void
    {
        $this->departureDate = $departureDate;
    }

    public function getArrivalDate(): ?\DateTimeInterface
    {
        return $this->arrivalDate;
    }

    public function setArrivalDate(?\DateTimeInterface $arrivalDate): void
    {
        $this->arrivalDate = $arrivalDate;
    }

    public function getArrivalFlightNumber(): ?string
    {
        return $this->arrivalFlightNumber;
    }

    public function setArrivalFlightNumber(?string $arrivalFlightNumber): void
    {
        $this->arrivalFlightNumber = $arrivalFlightNumber;
    }

    public function getDepartureFlightNumber(): ?string
    {
        return $this->departureFlightNumber;
    }

    public function setDepartureFlightNumber(?string $departureFlightNumber): void
    {
        $this->departureFlightNumber = $departureFlightNumber;
    }

    public function getTotalPrice(): ?string
    {
        return $this->totalPrice;
    }

    public function setTotalPrice(?string $totalPrice): void
    {
        $this->totalPrice = $totalPrice;
    }

    public function getBookingTypeEnum(): ?BookingTypeEnum
    {
        return $this->bookingTypeEnum;
    }

    public function setBookingTypeEnum(?BookingTypeEnum $bookingTypeEnum): void
    {
        $this->bookingTypeEnum = $bookingTypeEnum;
    }

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): void
    {
        $this->note = $note;
    }

    public function getStatus(): ?EnumBookingStatus
    {
        return $this->status;
    }

    public function setStatus(?EnumBookingStatus $status): void
    {
        $this->status = $status;
    }


    public function getDiscount(): ?string
    {
        return $this->discount;
    }

    public function setDiscount(?string $discount): void
    {
        $this->discount = $discount;
    }

    public function getActive(): ?bool
    {
        return $this->active;
    }

    public function setActive(?bool $active): void
    {
        $this->active = $active;
    }

    public function getTravel(): ?Travel
    {
        return $this->travel;
    }

    public function setTravel(?Travel $travel): void
    {
        $this->travel = $travel;
    }

    public function getDriver(): ?Users
    {
        return $this->driver;
    }

    public function setDriver(?Users $driver): void
    {
        $this->driver = $driver;
    }

    public function getUser(): ?Users
    {
        return $this->user;
    }

    public function setUser(?Users $user): void
    {
        $this->user = $user;
    }

    public function getReports(): Collection
    {
        return $this->reports;
    }

    public function setReports(Collection $reports): void
    {
        $this->reports = $reports;
    }

    public function getTravelBaggageList(): Collection
    {
        return $this->travelBaggageList;
    }

    public function setTravelBaggageList(Collection $travelBaggageList): void
    {
        $this->travelBaggageList = $travelBaggageList;
    }


}
