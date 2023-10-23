<?php

namespace App\Controller;

use App\Entity\Enterprise;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class FaqController extends AbstractController
{
    private $name;

    public function __construct()
    {
        $ent = new Enterprise();
        $this->name = $ent->getName();
    }

    #[Route('/faq', name: 'faq')]
    public function index(): Response
    {
        return $this->render('faq/faq.html.twig', ['nameEntreprise' => $this->name,]);
    }
}
