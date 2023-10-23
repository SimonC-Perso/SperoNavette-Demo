<?php

namespace App\Controller\Admin;

use App\Controller\Prices\e;
use App\Entity\Enterprise;
use App\Entity\Prices;
use App\Entity\PricesHistories;
use App\Entity\Users;
use App\Form\PriceManagerFormType;
use App\Form\PricesFormType;
use App\Form\SearchFormType;
use App\Normalizer\CitiesNormalizer;
use App\Normalizer\PricesNormalizer;
use App\Normalizer\UsersAdminNormalizer;
use App\Repository\CitiesRepository;
use App\Services\CitiesService;
use App\Services\PricesHistoryService;
use App\Services\PricesService;
use Doctrine\ORM\EntityManagerInterface;
use JetBrains\PhpStorm\NoReturn;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\SearchType;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Contracts\Translation\TranslatorInterface;

class PriceManagementController extends AbstractController
{
    private string $name;
    private TranslatorInterface $translator;

    public function __construct(TranslatorInterface $translator)
    {
        $ent = new Enterprise();
        $this->name = $ent->getName();
        $this->translator = $translator;
    }

    #[Route('/admin/priceManagement/new', name: 'priceManagement/new')]
    #[NoReturn] #[Route('/admin/priceManagement/update', name: 'priceManagement/update')]
    public function priceManagement(Request $request, EntityManagerInterface $manager, PaginatorInterface $paginator): Response
    {
        try {
            $form = $this->createForm(PriceManagerFormType::class);
            $form->get('from')->remove('Country');
            $form->get('to')->remove('Country');
            $form->remove('field_name');
            $searchForm = $this->createForm(SearchFormType::class);
            if ($request->attributes->get('_route') === 'priceManagement/new') {
                return $this->render('admin/price_management/index.html.twig', [
                    'nameEnterprise' => $this->name,
                    'pricesForm' => $form,
                    'searchForm' => $searchForm,
                ]);
            } else {
                if ($request->query->all('search_form') !== [])
                    $search = $request->query->all('search_form')['search'];
                else
                    $search = '';
                $page = $paginator->paginate(
                    $manager->getRepository(Prices::class)->findByPagination($search),
                    $request->query->get('page', 1),
                    20);
                // dd($page);
                return $this->render('admin/price_management/edit.html.twig', [
                    'nameEnterprise' => $this->name,
                    'searchForm' => $searchForm,
                    'pricesForm' => $form,
                    'page' => $page
                ]);
            }
            //  dd('test');

        } catch (\Exception $e) {
            $this->addFlash('warning', $this->translator->trans('error.error'));
            return $this->redirectToRoute('app_admin');
        }
    }

    #[NoReturn] #[Route('/admin/priceManagement/save', name: 'savePrices')]
    #[NoReturn] #[Route('/admin/priceManagement/updatePrice', name: 'updatePrice')]
    public function savePrices(Request $request, EntityManagerInterface $manager, PricesService $pricesService, PricesHistoryService $pricesHistoryService, CitiesService $citiesService): Response
    {
        try {
            $update = false;
            $prices = new Prices();
            $priceExist = null;
            $priceHistories = array();
            $form = $this->createForm(PriceManagerFormType::class);
            $form->handleRequest($request);
            if ($request->attributes->get('_route') === 'updatePrice') {
                //  dd($request);
                $update = true;
                $priceExist = $pricesService->findById($request->request->get('priceId'));
                $prices->setPrice($request->request->get('price'));
                $prices->setTo($priceExist->getTo());
                $prices->setFrom($priceExist->getFrom());
                $prices->setDate(new \DateTime());
                $priceHistories = $pricesHistoryService->getPriceHistories($priceExist);
//                dd($priceHistories);

            } else {
                if ($form->isSubmitted() && $form->isValid()) {
                    $data = $form->getData();
                    // dd($prices['from']);
                    $priceExist = $pricesService->getTravelPrices($data['from']->getZipCode(), $data['to']->getZipCode());
                    $prices->setPrice($data['price']);
                    $prices->setFrom($citiesService->findCityById($data['from']->getZipCode()));
                    $prices->setTo($citiesService->findCityById($data['to']->getZipCode()));
                }
            }
            try {
                $prices->setDate(new \DateTime());
                //dd($priceExist);
                if ($priceExist != null) {
                    $priceHistories = $pricesHistoryService->getPriceHistories($priceExist);
                    $priceHistory = new PricesHistories();
                    $priceHistory->setPreviousPrice($priceExist->getPrice());
                    $priceHistory->setBeginDate($priceExist->getDate());
                    $priceHistory->setEndDate(new \DateTime());
                    $priceHistory->setPrice($prices);
                    $manager->persist($priceHistory);
                    $manager->remove($priceExist);
                }
//                dd($prices);
                $manager->persist($prices);
                if ($priceHistories != null && count($priceHistories) > 0) {
                    foreach ($priceHistories as $priceHistory) {
                        $priceHistoryNew = $pricesHistoryService->findById($priceHistory->getId());
                        $priceHistoryNew->setBeginDate($priceHistory->getBeginDate());
                        $priceHistoryNew->setEndDate($priceHistory->getEndDate());
                        $priceHistoryNew->setPreviousPrice($priceHistory->getPreviousPrice());
                        $priceHistoryNew->setPrice($prices);
                        $manager->persist($priceHistoryNew);
                    }
                }
                $manager->flush();
            } catch (\Exception $e) {
                dd("exception " . $e->getMessage());
                $this->addFlash('warning', $this->translator->trans('error.error'));
                return $this->redirectToRoute('app_admin');
            }
        } catch (\Exception $e) {
            $this->addFlash('warning', $this->translator->trans('error.error'));
            return $this->redirectToRoute('app_admin');
        }
        if ($update) {
            $this->addFlash('success', $this->translator->trans('priceManagement.success.update'));
            return $this->redirectToRoute('priceManagement/update');
        }
//        dd($this->createForm(PricesFormType::class));
        $form = $this->createForm(PriceManagerFormType::class);
        $form->get('from')->remove('Country');
        $form->get('to')->remove('Country');
        $form->remove('field_name');
        $this->addFlash('success', $this->translator->trans('priceManagement.success.create'));
        return $this->render('admin/price_management/index.html.twig', [
            'nameEnterprise' => $this->name,
            'pricesForm' => $form,

        ]);
    }

    #[Route('/admin/priceManagement/getPrice/{id}', name: 'getPrice')]
    public function getPrice(Request $request, PricesService $pricesService): JsonResponse
    {
        //dd($request->attributes->get('id'));
        $id = $request->attributes->get('id');
        $price = $pricesService->findById($id);
        $encoders = [new JsonEncoder()];
        $normalizers = [new PricesNormalizer(), new ObjectNormalizer()];
        $serializer = new Serializer($normalizers, $encoders);
        $json = $serializer->serialize($price, 'json', ['circular_reference_handler' => function ($object) {
            return $object->getId();
        }]);
        return new JsonResponse($json);
    }
}