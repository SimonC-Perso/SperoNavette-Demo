<?php

namespace App\Controller\Auth;


use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class LoginController extends AbstractController
{

    #[Route('/login', name: 'login', methods: 'POST')]
    public function login(Request $request, EntityManagerInterface $manager): Response
    {

        return $this->redirectToRoute('index');

    }

    #[Route('/logout', name: 'logout')]
    public function logout(Request $request): Response
    {
        $session = $request->getSession();
        $session->remove('filter');

        return $this->redirectToRoute('index');
    }
}
