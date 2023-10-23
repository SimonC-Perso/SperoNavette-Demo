<?php

namespace App\Controller\Cities;

use App\Entity\Airports;
use App\Entity\Cities;
use App\Normalizer\AddressesNormalizer;
use App\Normalizer\AirportNormalizer;
use App\Normalizer\AirportSelect2Normalizer;
use App\Normalizer\CitiesNormalizer;
use App\Normalizer\CitiesSelect2Normalizer;
use App\Utils\Tools;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

class CitiesController extends AbstractController
{
    #[Route('/locality', name: 'locality')]
    public function getLocality(Request $request, EntityManagerInterface $entityManager): JsonResponse
    {
        $cp = $request->query->get('cp');
        $countryId = $request->query->get('country');
        $Locality = $entityManager->getRepository(Cities::class)->findBy(['zipcode' => $cp, 'country' => $countryId]);
        $encoders = [new JsonEncoder()]; // If no need for XmlEncoder
        $normalizers = [new CitiesNormalizer(), new ObjectNormalizer()];
        $serializer = new Serializer($normalizers, $encoders);
        $json = $serializer->serialize($Locality, 'json');
        return new JsonResponse($json);
    }

    #[Route('/locality/airport', name: 'airport')]
    public function getAirport(Request $request, EntityManagerInterface $entityManager): JsonResponse
    {
        $cp = $request->query->get('cp');
        $Airport = $entityManager->getRepository(Airports::class)->findAll();
        $encoders = [new JsonEncoder()]; // If no need for XmlEncoder
        $normalizers = [new AirportNormalizer(), new AddressesNormalizer(), new CitiesNormalizer(), new ObjectNormalizer()];
        $serializer = new Serializer($normalizers, $encoders);
        $json = $serializer->serialize($Airport, 'json');
        return new JsonResponse($json);
    }

    #[Route('/getCities', name: 'getCities')]
    public function getCities(Request $request, EntityManagerInterface $entityManager): JsonResponse
    {
        $city = $request->query->get('cp');
        $country = $request->query->get('country');
        $airportSearch = ['aeroport', 'aéroport'];
//        dd(Tools::startsWith($airportSearch, $city));
        if (Tools::startsWith($airportSearch, $city)) {
            $airports = $entityManager->getRepository(Airports::class)->findAll();
            $encoders = [new JsonEncoder()]; // If no need for XmlEncoder
            $normalizers = [new AirportSelect2Normalizer(), new ObjectNormalizer()];
            $serializer = new Serializer($normalizers, $encoders);
            $json = $serializer->serialize($airports, 'json');
            return new JsonResponse($json);
        } else {
            if (!is_numeric($city)) {
                $cities = $entityManager->getRepository(Cities::class)->findByCities($city);
                $encoders = [new JsonEncoder()]; // If no need for XmlEncoder
                $normalizers = [new CitiesSelect2Normalizer(), new ObjectNormalizer()];
                $serializer = new Serializer($normalizers, $encoders);
                $json = $serializer->serialize($cities, 'json');
                return new JsonResponse($json);
            } else {
                if ($country !== null)
                    $Locality = $entityManager->getRepository(Cities::class)->findCitiesByZipLikeAndCountry($city, $country);
                else
                    $Locality = $entityManager->getRepository(Cities::class)->findCitiesByZipLike($city);
                $encoders = [new JsonEncoder()]; // If no need for XmlEncoder
                $normalizers = [new CitiesSelect2Normalizer(), new ObjectNormalizer()];
                $serializer = new Serializer($normalizers, $encoders);
                $json = $serializer->serialize($Locality, 'json');
                return new JsonResponse($json);
            }
        }
    }
}
