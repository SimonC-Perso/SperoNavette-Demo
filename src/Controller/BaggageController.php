<?php

namespace App\Controller;

use App\Services\BaggageService;
use App\Normalizer\BaggageNormalizer;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

class BaggageController extends AbstractController
{
    private BaggageService $baggageService;

    public function __construct(BaggageService $baggageService)
    {
        $this->baggageService = $baggageService;
    }

    #[Route('/getAllBaggageByFilter', name: 'getAllBaggageByFilter')]
    public function getAllBaggageByFilter(Request $request): JsonResponse
    {
        try {
            $term = $request->get('filters');
            $result = $this->baggageService->getAllBaggageByFilter($term);
            $encoders = [new JsonEncoder()];
            $normalizers = [new BaggageNormalizer(), new ObjectNormalizer()];
            $serializer = new Serializer($normalizers, $encoders);
            $json = $serializer->serialize($result, 'json');
            return new JsonResponse($json);
        } catch (\Exception $e) {
            return new JsonResponse($e);
        }
    }
}
