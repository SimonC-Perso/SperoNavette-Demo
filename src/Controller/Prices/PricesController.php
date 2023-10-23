<?php

namespace App\Controller\Prices;

use App\Normalizer\BaggageNormalizer;
use App\Normalizer\PricesNormalizer;
use App\Services\PricesService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

class PricesController extends AbstractController
{
    private PricesService $priceService;

    /**
     * @param PricesService $priceService
     */
    public function __construct(PricesService $priceService)
    {
        $this->priceService = $priceService;
    }

    #[Route('/getPrices', name: 'getPrices')]
    public function getPrices(Request $request): JsonResponse
    {
        try {

            $from = $request->get('fromId');
            $to = $request->get('toId');
            $result = $this->priceService->getTravelPrices($from, $to);
            $encoders = [new JsonEncoder()];
            $normalizers = [new PricesNormalizer(), new ObjectNormalizer()];
            $serializer = new Serializer($normalizers, $encoders);
            $json = $serializer->serialize($result, 'json');
            return new JsonResponse($json);
        } catch (\Exception $e) {
            return new JsonResponse($e);
        }
    }
}
