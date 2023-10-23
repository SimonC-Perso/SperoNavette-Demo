<?php

namespace App\Controller\Admin;

use App\Controller\e;
use App\Entity\Enterprise;
use App\Entity\Users;
use App\Form\AdminUserType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class UserDetailsController extends AbstractController
{
    private string $name;

    public function __construct()
    {
        $ent = new Enterprise();
        $this->name = $ent->getName();
    }

    #[Route('admin/user_details/{id}', name: 'user_details')]
    public function userDetails(Request $request, EntityManagerInterface $manager): RedirectResponse|Response
    {

        $id = $request->attributes->get('id');
        try {
            $user = $manager->getRepository(Users::class)->find($id);
            $userForm = $this->createForm(AdminUserType::class, $user);
            $userForm->remove('password');
            $userForm->remove('confirmPassword');
            $userForm->handleRequest($request);
            if ($userForm->isSubmitted() && $userForm->isValid() && isset($_POST['update'])) {
                try {
                    $user = $userForm->getData();
                    $manager->persist($user);
                    $manager->flush();
                    $request->getSession()->getFlashBag()->add('success', 'Informations mise à jour avec succès');
                    return $this->redirectToRoute('app_user_list');
                } catch (e) {
                    $request->getSession()->getFlashBag()->add('error', 'Erreur lors de la mise à jour');
                    return $this->redirectToRoute('app_user_list');
                }
            } else if (isset($_POST['delete'])) {
                try {
                    $user->setActive(false);
                    $manager->persist($user);
                    $manager->flush();
                    $request->getSession()->getFlashBag()->add('success', 'Utilisateur supprimé');
                    return $this->redirectToRoute('app_user_list');
                } catch (e) {
                    $request->getSession()->getFlashBag()->add('error', 'Erreur survenue lors de la suppression');
                    return $this->redirectToRoute('app_user_list');
                }
            }
        } catch (e) {
            $request->getSession()->getFlashBag()->add('error', 'Utilisateur introuvable');
            return $this->redirectToRoute('app_user_list');
        }


        return $this->render('admin/userDetails.html.twig', [
            'nameEnterprise' => $this->name,
            'userForm' => $userForm->createView(),
        ]);
    }
}
