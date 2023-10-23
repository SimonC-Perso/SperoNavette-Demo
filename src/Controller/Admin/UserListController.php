<?php

namespace App\Controller\Admin;

use App\Entity\Enterprise;
use App\Entity\Enum\EnumUserStatus;
use App\Entity\Users;
use App\Form\AdminUserType;
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

class UserListController extends AbstractController
{
    private string $name;

    public function __construct()
    {
        $ent = new Enterprise();
        $this->name = $ent->getName();
    }


    #[Route('/admin/list', name: 'app_user_list')]
    public function userList(Request $request, EntityManagerInterface $manager, PaginatorInterface $paginator): Response
    {
        try {
            $page = $paginator->paginate($manager->getRepository(Users::class)->findByPagination(), $request->query->get('page', 1), 20);
        } catch (e) {
            $request->getSession()->getFlashBag()->add('warning', 'Une erreur inattendue est survenue');
            return $this->redirectToRoute('app_admin');
        }

        return $this->render('admin/userList.html.twig', [
            'nameEnterprise' => $this->name,
            'page' => $page,
        ]);
    }

    #[Route('/admin/liveSearch', name: 'liveSearch')]
    public function liveSearch(Request $request, EntityManagerInterface $manager)
    {
        $input = $request->get('input');
        try {
            $results = $manager->getRepository(Users::class)->findBySearch($input);
            $encoders = [new JsonEncoder()];
            $normalizers = [new UsersAdminNormalizer(), new ObjectNormalizer()];
            $serializer = new Serializer($normalizers, $encoders);
            $json = $serializer->serialize($results, 'json', ['circular_reference_handler' => function ($object) {
                return $object->getId();
            }]);
            return new JsonResponse($json);
        } catch (e) {
            $request->getSession()->getFlashBag()->add('warning', 'Erreur de communication');
            return null;
        }
    }

    #[Route('/admin/fillModal', name: 'fillModal')]
    public function fillModal(Request $request, EntityManagerInterface $manager): ?JsonResponse
    {

        $id = $request->get('modalId');

        try {
            $result = $manager->getRepository(Users::class)->find($id);
            $encoders = [new JsonEncoder()];
            $normalizers = [new UsersAdminNormalizer(), new ObjectNormalizer()];
            $serializer = new Serializer($normalizers, $encoders);
            $json = $serializer->serialize($result, 'json', ['circular_reference_handler' => function ($object) {
                return $object->getId();
            }]);
            return new JsonResponse($json);
        } catch (e) {
            $request->getSession()->getFlashBag()->add('warning', 'Informations erronées');
            return null;
        }

    }


}
