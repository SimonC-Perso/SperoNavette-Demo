<?php

namespace App\Controller\Admin;

use App\Entity\Enterprise;
use App\Entity\Enterprises;
use App\Entity\Enum\EnumUserStatus;
use App\Entity\Booking;
use App\Entity\Roles;
use App\Entity\Users;
use App\Form\AdminUserType;
use App\Form\EnterpriseForm;
use App\Normalizer\UsersAdminNormalizer;
use App\Normalizer\UsersNormalizer;
use Doctrine\ORM\EntityManagerInterface;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

class AdminController extends AbstractController
{
    private string $name;

    public function __construct()
    {
        $ent = new Enterprise();
        $this->name = $ent->getName();
    }

    #[Route('/admin/dashboard', name: 'app_admin')]
    public function accountAdminForm(Request $request, EntityManagerInterface $manager, UserPasswordHasherInterface $passwordHasher, PaginatorInterface $paginator): Response
    {
        $user = new Users();
        $userForm = $this->createForm(AdminUserType::class, $user, array('validation_groups' => 'admin'));
        $userForm->remove('statusUser');
        $userForm->handleRequest($request);
        if ($userForm->isSubmitted() && $userForm->isValid()) {
            try {
                $user = $userForm->getData();
                $passHashed = $passwordHasher->hashPassword($user, $user->getPassword());
                $user->setPassword($passHashed);
                $user->setStatutUSer(EnumUserStatus::Ok);
                if ($user->getRoles() === null) $user->setRoles($manager->getRepository(Roles::class)->findOneByLabel('user'));
                $manager->persist($user);
                $manager->flush();
                $request->getSession()->getFlashBag()->add('success', 'Utilisateur créé avec succès');
                return $this->redirectToRoute('app_admin');
            } catch (e) {
                $request->getSession()->getFlashBag()->add('error', 'Erreur inattendue');
                return $this->redirectToRoute('app_admin');
            }
        }

        $entreprise = new Enterprises();
        $enterpriseForm = $this->createForm(EnterpriseForm::class, $entreprise);
        $enterpriseForm->handleRequest($request);
        if ($enterpriseForm->isSubmitted() && $enterpriseForm->isValid()) {
            try {
                $entrepriseSubmit = $enterpriseForm->getData();
                $entrepriseSubmit->setDate(new \DateTime('now'));
                $manager->persist($entrepriseSubmit);
                $manager->flush();
                $request->getSession()->getFlashBag()->add('success', 'Informations mise à jour avec succès');
                return $this->redirectToRoute('app_admin');
            } catch (e) {
                $request->getSession()->getFlashBag()->add('error', 'Erreur inattendue');
                return $this->redirectToRoute('app_admin');
            }

        }

        try {
            $page = $paginator->paginate($manager->getRepository(Booking::class)->findByPagination(), $request->query->get('page', 1), 20);
            //dd($page);
        } catch (e) {
            $request->getSession()->getFlashBag()->add('Warning', 'Une erreur inattendue est survenue');
            return $this->redirectToRoute('app_admin');
        }

        return $this->render('admin/dashboard.html.twig', [
            'nameEnterprise' => $this->name,
            'enterpriseForm' => $enterpriseForm->createView(),
            'userForm' => $userForm->createView(),
            'page' => $page,
        ]);
    }

    #[Route('/admin/checkUserEmail', name: 'checkUserEmail')]
    public function checkUserEmail(Request $request, EntityManagerInterface $manager): Response
    {

        $userEmail = $request->get('email');
        $User = $manager->getRepository(Users::class)->findByEmail($userEmail);
        $encoders = [new JsonEncoder()];
        $normalizers = [new UsersNormalizer(), new ObjectNormalizer()];
        $serializer = new Serializer($normalizers, $encoders);
        $json = $serializer->serialize($User, 'json', ['circular_reference_handler' => function ($object) {
            return $object->getId();
        }]);

        return new JsonResponse($json);
    }

    #[Route('/admin/fillEForm', name: 'fillEForm')]
    public function fillEForm(EntityManagerInterface $manager): Response
    {
        $e = $manager->getRepository(Enterprises::class)->findOneBy(array(), array('date' => 'DESC'));
        $encoders = [new JsonEncoder()];
        $normalizers = [new ObjectNormalizer()];
        $serializer = new Serializer($normalizers, $encoders);
        $json = $serializer->serialize($e, 'json', ['circular_reference_handler' => function ($object) {
            return $object->getId();
        }]);
        return new JsonResponse($json);
    }

//    #[Route('/admin/fillUList', name: 'fillUList')]
//    public function fillUList(EntityManagerInterface $manager): Response
//    {
//        $u = $manager->getRepository(Users::class)->findBy(array('isActive' => 'true'), array('last_name' => 'ASC'));
//        $encoders = [new JsonEncoder()];
//        $normalizers = [new UsersAdminNormalizer(), new ObjectNormalizer()];
//        $serializer = new Serializer($normalizers, $encoders);
//        $json = $serializer->serialize($u, 'json', ['circular_reference_handler' => function ($object) {
//            return $object->getId();
//        }]);
//        return new JsonResponse($json);
//    }
}
