<?php

namespace App\Controller\Auth;

use App\Entity\Enterprise;
use App\Entity\Enum\EnumUserStatus;
use App\Entity\Roles;
use App\Entity\Users;
use App\Form\UserType;
use App\Normalizer\UsersNormalizer;
use App\Services\UsersService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Csrf\CsrfToken;
use Symfony\Component\Security\Csrf\CsrfTokenManagerInterface;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

class UsersController extends AbstractController
{

    private $name;
    private $userService;

    public function __construct(UsersService $userService)
    {

        $this->userService = $userService;
        $ent = new Enterprise();
        $this->name = $ent->getName();
    }

    /**
     * Vérifie si l'email existe dans la db
     * @param Request $request
     * @param EntityManagerInterface $manager
     * @return Response
     */
    #[Route('/account/checkMail', name: 'checkMail')]
    public function checkMail(Request $request, EntityManagerInterface $manager): Response
    {
        $email = $request->get('email');
        $userMail = $this->userService->findByEmail($email);
        $encoders = [new JsonEncoder()];
        $normalizers = [new UsersNormalizer(), new ObjectNormalizer()];
        $serializer = new Serializer($normalizers, $encoders);
        $json = $serializer->serialize($userMail, 'json');
        return new JsonResponse($json);
    }


    /**
     * @param Request $request
     * @param EntityManagerInterface $manager
     * @return Response
     */
    #[Route('/account/new', name: 'account')]
    #[Route('/account/edit/{id}', name: 'account-edit')]
    public function accountForm(Request $request, EntityManagerInterface $manager): Response
    {
        $update = false;
        //Vérifie la route pour le EDITMODE
        if ($request->attributes->get('_route') === 'account-edit') {
            $idUser = $this->getUser()->getId();
            if ($idUser == $request->attributes->get('id')) {
                $user = $this->userService->findUserById($idUser);
            } else {
                return $this->redirectToRoute('index');
            }
            $update = true;
        } else {
            $user = new Users();
        }

        //Si on est en EDITMODE , on retire le mot de passe du formulaire.
        if ($update) {
            //Création du formulaire
            $userForm = $this->createForm(UserType::class, $user, array('validation_groups' => 'default'));
            $userForm->remove('password');
            $userForm->remove('confirmPassword');
        } else {
            $userForm = $this->createForm(UserType::class, $user, array('validation_groups' => 'registration'));
        }
        $userForm->handleRequest($request);

        //Vérifie si le formulaire est envoyé et valide
        if ($userForm->isSubmitted() && $userForm->isValid()) {
            try {
                $user = $userForm->getData();


                //Vérifie le EDITMODE ou CREATE
                if (!$update) {

                    //Crypt le mot de passe
                    $user->setPassword($this->userService->cryptPassword($user->getPassword()));

                    //Définis le statut
                    $user->setStatutUSer(EnumUserStatus::Ok);

                    //Définis le role par défaut : User
                    $role = $manager->getRepository(Roles::class)->findOneByLabel('user');
                    $user->setRoleId($role);
                }
                $manager->persist($user);
                $manager->flush();
                if (!$update) {
                    $request->getSession()->getFlashBag()->add('success', 'Votre compte a été créé avec succès');
                    return $this->redirectToRoute('index');
                } else {
                    $request->getSession()->getFlashBag()->add('success', 'Informations mise à jour avec succès');
                    return $this->redirectToRoute('index');
                }
            } catch (e) {
                $request->getSession()->getFlashBag()->add('error', 'Une erreur est survenue');
                return $this->redirectToRoute('index');
            }

        }

        return $this->render('users/account.html.twig', [
            "nameEnterprise" => $this->name,
            "userForm" => $userForm->createView(),
            "editMode" => $update
        ]);
    }
}
