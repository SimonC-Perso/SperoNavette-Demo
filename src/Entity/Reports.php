<?php

namespace App\Entity;

use App\Repository\ReportsRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ReportsRepository::class)]
class Reports
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 500)]
    private ?string $text = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $date = null;

    #[ORM\ManyToOne(inversedBy: 'reports')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Booking $booking = null;

    #[ORM\ManyToOne]
    #[ORM\JoinColumn(nullable: false)]
    private ?Users $user = null;

    #[ORM\OneToMany(mappedBy: 'report_id', targetEntity: ReportsHistory::class)]
    private Collection $reportsHistories;

    public function __construct()
    {
        $this->reportsHistories = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getText(): ?string
    {
        return $this->text;
    }

    public function setText(string $text): self
    {
        $this->text = $text;

        return $this;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(\DateTimeInterface $date): self
    {
        $this->date = $date;

        return $this;
    }

    public function getBooking(): ?Booking
    {
        return $this->booking;
    }

    public function setBooking(?Booking $booking): self
    {
        $this->booking = $booking;

        return $this;
    }

    public function getUser(): ?Users
    {
        return $this->user;
    }

    public function setUser(?Users $user): self
    {
        $this->user = $user;

        return $this;
    }

    /**
     * @return Collection<int, ReportsHistory>
     */
    public function getReportsHistories(): Collection
    {
        return $this->reportsHistories;
    }

    public function addReportsHistory(ReportsHistory $reportsHistory): self
    {
        if (!$this->reportsHistories->contains($reportsHistory)) {
            $this->reportsHistories->add($reportsHistory);
            $reportsHistory->setReport($this);
        }

        return $this;
    }

    public function removeReportsHistory(ReportsHistory $reportsHistory): self
    {
        if ($this->reportsHistories->removeElement($reportsHistory)) {
            // set the owning side to null (unless already changed)
            if ($reportsHistory->getReport() === $this) {
                $reportsHistory->setReport(null);
            }
        }

        return $this;
    }
}
