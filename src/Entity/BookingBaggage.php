<?php

namespace App\Entity;

use App\Repository\BookingBaggageRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: BookingBaggageRepository::class)]
class BookingBaggage
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $quantity = null;

    #[ORM\ManyToOne]
    #[ORM\JoinColumn(nullable: false)]
    private ?Baggage $baggage = null;

    #[ORM\ManyToOne(inversedBy: 'bookingBaggage')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Booking $booking = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getQuantity(): ?string
    {
        return $this->quantity;
    }

    public function setQuantity(?string $quantity): void
    {
        $this->quantity = $quantity;
    }

    public function getBaggage(): ?Baggage
    {
        return $this->baggage;
    }

    public function setBaggage(?Baggage $baggage): void
    {
        $this->baggage = $baggage;
    }

    public function getBooking(): ?Booking
    {
        return $this->booking;
    }

    public function setBooking(?Booking $booking): void
    {
        $this->booking = $booking;
    }

}
