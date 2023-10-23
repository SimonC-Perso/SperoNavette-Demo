<?php

namespace App\Controller;

use App\Entity\Addresses;
use App\Entity\Enterprise;
use App\Form\AddressesForm;
use App\Form\BookingSimulatorFormType;
use App\Form\ContactType;
use App\Form\BookingForm;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Annotation\Route;


class IndexController extends AbstractController
{
    private $name;

    public function __construct()
    {
        $ent = new Enterprise();
        $this->name = $ent->getName();
    }

    #[Route('/', name: 'index')]
    public function index(Request $request): Response
    {

        //Création du formulaire de réservation.
        $bookingForm = $this->createForm(BookingSimulatorFormType::class);
        $contactForm = $this->createForm(ContactType::class);
        $session = $request->getSession();
        $session->set("nameEnterprise", $this->name);
        return $this->render('View/index.html.twig', [
            'contactForm' => $contactForm->createView(),
            "nameEnterprise" => $this->name,
            "bookingForm" => $bookingForm->createView(),
        ]);
    }
}
