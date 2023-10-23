<?php

namespace App\Controller;

use App\Entity\BaggageTypes;
use App\Normalizer\BaggageNormalizer;
use App\Normalizer\TypesBagagesNormalizer;
use App\Services\TypesBaggageService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Config\Doctrine\Orm\EntityManagerConfig;

class TypesBaggageController extends AbstractController
{

    private TypesBaggageService $typesBaggageService;

    public function __construct(TypesBaggageService $typesBaggageService)
    {
        $this->typesBaggageService = $typesBaggageService;
    }

    #[Route('/getAllBaggageType', name: 'getAllBaggageType')]
    public function index(): JsonResponse
    {
        try {
            $filtersBaggage = $this->typesBaggageService->getAllIsActive();
            $encoders = [new JsonEncoder()];
            $normalizers = [new TypesBagagesNormalizer(), new BaggageNormalizer(), new ObjectNormalizer()];
            $serializer = new Serializer($normalizers, $encoders);
            $json = $serializer->serialize($filtersBaggage, 'json');
            return new JsonResponse($json);
        } catch (\Exception $e) {
            dd($e);
            return new JsonResponse($e);
        }
    }
}
