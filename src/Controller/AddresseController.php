<?php

namespace App\Controller;

use App\Entity\Addresses;
use App\Entity\Cities;
use App\Normalizer\CitiesNormalizer;
use App\Services\AddressesService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

class AddresseController extends AbstractController
{
    private AddressesService $addressesService;
    public function __construct(AddressesService $addressesService)
    {
        $this->addressesService = $addressesService;
    }
    #[Route('/checkStreet', name: 'checkStreet')]
    public function checkStreet(Request $request): JsonResponse
    {
        try {
            $term = $request->get('streetName');
            $addresses = $this->addressesService->checkByStreetName($term);
            $result = $addresses;
            $encoders = [new JsonEncoder()];
            $normalizers = [new CitiesNormalizer(), new ObjectNormalizer()];
            $serializer = new Serializer($normalizers,$encoders);
            $json = $serializer->serialize($result, 'json');
            return new JsonResponse($json);
        }catch(\Exception $e){
            return new JsonResponse($e);
        }

    }

    #[Route('/checkCodePostal', name: 'checkCodePostal')]
    #[Route('/checkLocalite', name: 'checkLocalite')]
    public function checkCodePostal(Request $request, EntityManagerInterface $manager): Response
    {
        try{
            if($request->attributes->get('_route')==='checkCodePostal'){
                $term = $request->get('codePostal');
                $cities = $manager->getRepository(Cities::class)->findByCodePostal($term);
            }else{
                $term = $request->get('localite');
                $cities = $manager->getRepository(Cities::class)->findBylocalite($term);
            }

            $encoders = [new JsonEncoder()];
            $normalizers = [new CitiesNormalizer(), new ObjectNormalizer()];
            $serializer = new Serializer($normalizers,$encoders);
            $json = $serializer->serialize($cities, 'json');
            return new JsonResponse($json);
        }catch(\Exception $e){
            return new JsonResponse($e);
        }

    }
}
